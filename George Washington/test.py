import pandas as pd
import seaborn as sns

def heat_map(
        df: pd.DataFrame,
        color: str = 'lime',
        fmt: str = '{:.0f}'
) -> 'pd.io.formats.style.Styler':
    """Adds color to a dataframe. Used earnestly to convey data in a more
    readable way, or cynically to beguile management with cheap tricks.

    :param df: Your lousy data.
    :param color: The gaudiest color you can imagine.
    :param fmt: Don't forget to format the cells.
    :return: A beautiful dataframe in technicolor.
    """
    cmap = sns.light_palette(color, as_cmap=True)
    return df.style.format(fmt).background_gradient(cmap=cmap, axis=None)


# =====================================
# example (renders in Jupyter Notebook)
# =====================================

df = pd.DataFrame({
    'x': range(1, 4),
    'y': range(4, 7),
    'z': range(7, 10)
}, index=['a', 'b', 'c'])
print(heat_map(df))
