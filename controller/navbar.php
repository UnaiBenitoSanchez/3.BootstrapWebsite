<style>
    .navbar-nav .nav-link {
        color: #ffffff;
        transition: color 0.3s;
    }

    .navbar-nav .nav-link:hover {
        color: #000000;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="landing_page.php" style="color: #ffffff">Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="products.php">Products from your factory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Your factory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.php">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>