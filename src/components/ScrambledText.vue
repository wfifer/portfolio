<template>
    <span>{{ scrambledText }}</span>
</template>

<script>
export default {
    name: 'ScrambledText',
    props: {
        text: {
            type: String,
            default: '',
        },
    },
    data: function () {
        return {
            scrambledText: '',
            scrambleTimer: null,
            updateText: function (newText, oldText) {
                var _this = this;
                window.clearInterval(this.scrambleTimer);
                if (oldText) {
                    let count = 0;
                    const newLetters = newText.split('').reverse();
                    const oldLetters = this.scrambledText.split('').reverse();
                    const maxLength = Math.max(
                        newLetters.length,
                        oldLetters.length
                    );

                    this.scrambleTimer = setInterval(function () {
                        if (count >= maxLength) {
                            _this.scrambledText = newText;
                            window.clearInterval(_this.scrambleTimer);
                        } else {
                            _this.scrambledText = new Array(maxLength)
                                .fill(0)
                                .map((_, index) => {
                                    return index == count
                                        ? randomLetter()
                                        : index > count
                                        ? oldLetters[index]
                                        : newLetters[index];
                                })
                                .reverse()
                                .join('');
                        }
                        count++;
                    }, 1000 / 20);
                } else {
                    this.scrambledText = newText;
                }
            },
        };
    },
    mounted() {
        this.updateText(this.text, null);
    },
    watch: {
        text: function (n, o) {
            this.updateText(n, o);
        },
    },
};

function randomLetter(upperCase) {
    const chr = getCharacterFromValue(Math.floor(Math.random() * 26));
    return upperCase ? chr.toUpperCase : chr;
}

function getCharacterFromValue(value) {
    return String.fromCharCode(97 + value);
}

function getValueFromCharacter(chr) {
    return chr.toLowerCase().charCodeAt(0) - 97;
}

function isUpperCase(chr) {
    return getValueFromCharacter(chr) < 0;
}
</script>
