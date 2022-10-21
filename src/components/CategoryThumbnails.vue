<template>
    <div class="category-thumbnails">
        <transition name="t-thumbnails">
            <div class="thumbnails-view" v-if="currentCategory">
                <!-- <div style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px">
					<img v-for="project in projects" :src="project.thumbnail.url" :key="`thumbnail-${ project.entryId }`" :alt="project.title" />
				</div> -->

                <div class="thumbnails-inner">
                    <div class="thumbnail-scroll">
                        <div class="scroll-inner">
                            <button
                                type="button"
                                class="btn btn-close-thumbnails"
                                title="Close project list"
                                tabindex="-1"
                                @click="clearCategory"
                            ></button>

                            <div class="category-label">
                                <strong>{{ currentCategory.title }}</strong>
                            </div>

                            <transition-group
                                name="t-thumbnail-item"
                                class="thumbnail-list list"
                                tag="ul"
                            >
                                <li
                                    v-for="project in activeProjects"
                                    class="thumbnail"
                                    :key="`thumbnail-${project.entryId}`"
                                >
                                    <button
                                        class="btn thumbnail-inner"
                                        type="button"
                                        :aria-label="`View ${project.title}`"
                                        @click="
                                            thumbnailClickHandler({
                                                entryId: project.entryId
                                            })
                                        "
                                    >
                                        <div class="thumbnail-text">
                                            {{ project.title }}
                                        </div>

                                        <div
                                            class="thumbnail-background"
                                            :style="
                                                `background-image: linear-gradient(${getGradient(
                                                    project
                                                )});`
                                            "
                                        >
                                            <span class="text">{{
                                                project.title
                                            }}</span>
                                        </div>
                                    </button>
                                </li>
                            </transition-group>
                        </div>
                    </div>

                    <!-- tools -->

                    <!-- <h2 class="category-heading">
						<span class="label">Projects in:</span>
						<span class="title">{{ currentCategory.title }}</span>
					</h2> -->

                    <ButtonDefault
                        class="btn btn-exit"
                        title="Exit category thumbnail view"
                        icon="times"
                        @click.native="clearCategory"
                    />

                    <div class="category-nav">
                        <CategoryButtons
                            :categories="categories"
                            class="icon-list icon-list-categories"
                            :active-category="parseInt(currentCategory.id, 10)"
                        />
                    </div>
                </div>
            </div>
        </transition>
    </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import CategoryButtons from '@/components/CategoryButtons';
import Icon from '@/components/Icon';
import ButtonDefault from '@/components/ButtonDefault';

export default {
    name: 'CategoryThumbnails',
    components: {
        CategoryButtons,
        Icon,
        ButtonDefault
    },
    mounted() {
        document.addEventListener('keyup', e => {
            if (e.which === 27) {
                this.clearCategory();
            }
        });
    },
    computed: {
        activeProjects() {
            return this.projects.filter(project => this.isActive(project));
        },
        ...mapState({
            currentCategory: state => state.projects.currentCategory,
            projects: state => state.projects.all,
            activeProject: state => state.projects.active,
            categories: state => state.projects.categories
        })
    },
    methods: {
        isActive(project) {
            let categories = project.categories.map(category => category.id);

            return (
                categories.indexOf(this.currentCategory.id) >= 0 ||
                this.currentCategory.slug === 'all'
            );
        },
        getGradient(project) {
            // let angle = project.heroBackground.angle;
            let angle = '37deg';
            let stops = project.heroBackground.stops.slice(0, 2);

            let gradient = angle && angle.length ? angle : 'to right';

            stops.forEach((stop, i) => {
                gradient += `, ${ stop.color } ${ 20 + i * 60 }%`;
            });

            return gradient;
        },
        getThumbnailBackground(project) {
            let color = parseInt(
                project.heroBackground.stops[0].color.replace('#', ''),
                16
            );

            let r = (color >> 16) & 255;
            let g = (color >> 8) & 255;
            let b = color & 255;

            return `rgba(${ [r, g, b].join(',') }, 0.9 )`;
        },
        thumbnailClickHandler(options) {
            this.clearCategory();

            let delay = 350;
            delay += options.entryId === this.activeProject ? 350 : 1500;

            window.setTimeout(() => {
                this.goToProject(options.entryId);
            }, 350);

            this.enterProject({ ...options, delay });
        },
        ...mapActions(['clearCategory', 'goToProject', 'enterProject'])
    }
};
</script>

<style src="../styles/components/icon-list.scss" lang="scss"></style>
<style
    src="@/styles/components/category-thumbnails.scss"
    lang="scss"
    scoped
></style>
