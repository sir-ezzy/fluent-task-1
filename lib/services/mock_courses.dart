import 'package:fluent/model/course_model.dart';

class MockCourses {
  static List<Course> get allCourses => [
    Course(
      id: 1,
      title: "Complete Web Development Bootcamp 2026",
      description:
          "Master modern web development from zero to professional level. This comprehensive bootcamp covers HTML5, CSS3, JavaScript (ES6+), responsive design, Git & GitHub, React.js, Next.js 15, Node.js, Express, MongoDB, REST APIs, authentication, deployment, and DevOps basics. You'll build 12+ real-world projects including e-commerce platforms, social media apps, dashboards, and SaaS products...",
      instructor: "Sarah Chen",
      instructorAvatar: "https://i.pravatar.cc/150?u=sarah",
      category: "Web Development",
      level: "Beginner",
      duration: "120 hours",
      price: 89.99,
      rating: 4.8,
      students: 12450,
      image: "https://picsum.photos/id/1015/800/600",
      tags: ["React", "Node.js", "Fullstack", "Next.js"],
      createdAt: DateTime.parse("2026-03-15"),
    ),
    Course(
      id: 2,
      title: "Python for Data Science & Machine Learning",
      description:
          "Become a proficient data scientist with this in-depth Python course. Learn Python fundamentals, data analysis with Pandas and NumPy, data visualization using Matplotlib & Seaborn, statistical analysis, machine learning algorithms...",
      instructor: "Dr. Michael Okoro",
      instructorAvatar: "https://i.pravatar.cc/150?u=michael",
      category: "Data Science",
      level: "Intermediate",
      duration: "95 hours",
      price: 129.99,
      rating: 4.9,
      students: 8730,
      image: "https://picsum.photos/id/201/800/600",
      tags: ["Python", "Machine Learning", "Data Science"],
      createdAt: DateTime.parse("2026-02-20"),
    ),
    Course(
      id: 3,
      title: "UI/UX Design Masterclass with Figma",
      description:
          "Transform your design skills with this complete UI/UX Design Masterclass. Learn user research, wireframing, prototyping, interaction design, design systems...",
      instructor: "Aisha Bello",
      instructorAvatar: "https://i.pravatar.cc/150?u=aisha",
      category: "Design",
      level: "Beginner",
      duration: "65 hours",
      price: 69.99,
      rating: 4.7,
      students: 5420,
      image: "https://picsum.photos/id/237/800/600",
      tags: ["Figma", "UI/UX", "Prototyping"],
      createdAt: DateTime.parse("2026-01-10"),
    ),
    Course(
      id: 4,
      title: "Advanced React & Next.js 15",
      description:
          "Take your React skills to the expert level with this advanced course on React and Next.js 15. Deep dive into Server Components, Server Actions, App Router...",
      instructor: "David Kim",
      instructorAvatar: "https://i.pravatar.cc/150?u=david",
      category: "Web Development",
      level: "Advanced",
      duration: "75 hours",
      price: 149.99,
      rating: 4.9,
      students: 3290,
      image: "https://picsum.photos/id/180/800/600",
      tags: ["Next.js", "React", "TypeScript"],
      createdAt: DateTime.parse("2026-03-01"),
    ),
  ];
}
