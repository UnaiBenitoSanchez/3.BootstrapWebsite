<style>
    .navbar{
        background-color: #2596be;
        opacity: 0.9;
        z-index: 100;
    }

    .navbar-nav .nav-link {
        color: #ffffff;
        transition: color 0.3s;
    }

    .navbar-nav .nav-link:hover {
        color: #000000;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="landing_page.php" style="color: #ffffff">Bootstrap Website</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.php">Products from your factory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="graphics.php">Production graphics</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="factory.php">Your factory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.php">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>