Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03553E0B;
	Sun, 21 Jun 2026 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782014958; cv=none; b=h79c6HQufUW/k0gdC8wEaDirJqccgzYTzzBheNNaC5rVJmvCmsFUjmlbvsn9j71xVYdUYTrC2nJdqOq244frq1PQpLus16s5Lftk+lPhFFlqcdWqwJ/kaTC2UWnmy6V3GO7RIb+zwFkKeNCaA7KyRfMrpVg5v55UOncPdbR3R5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782014958; c=relaxed/simple;
	bh=w5f5Kk4imEbO2n8ZcznHkUFyB58LUTYowg26bCVDZAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JraWTIkzngZQKK4ckRqv+CsWmjT9rkHMN68lVbVUweQClFZUt3/FxvhhLj/s9DhtMVe/5kvTgZ/udehXEi54KpgOVpg2w4gYWgD0wF8o+MNXGgeKV/DytZF03yZ85BgVTOTU6SELgjwUftEDPWClbgJAPrbQT0sZ6TnyTHDFUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALVQMP88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALVQMP88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E531F000E9;
	Sun, 21 Jun 2026 04:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782014957;
	bh=h706QQ6ZkpXo1Md9gfprirMvYlT+0jeg5Pp09PxaGdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ALVQMP88B8c+bNzF1Jr1kOeG0zof28960/6PrgIVxSQLdqZkI4QYsVlUG56LiaZkI
	 wkfT5vO3fciV3hjf5Ld/lJajFkxexS0A/sAjZ3E7lI2whDYsGMnk0zSqFtcXS3dW2t
	 sIALI9J0toPcMfQ8TZf5tfOy/innerGxj4QT0Wj7/XaqCphaPuKW9SBfxFq+CKCQ2I
	 jTV8szpE7Nd9HDXrOsIZv2NbnPu75qfhMjgDqbF9OliGG9g3nyd17UaGEZE6WQnlM2
	 C0CeNc0ZXjI2NhRB3IZRyRf21/Ucxu1bl7q3JEmEnR3f6YO/tPawj/1gB7jcU5krk+
	 iIneHfe3kpiKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] udf: avoid recursive s_alloc_mutex deadlock when
 freeing AED blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260621035841.56194-1-kartikey406@gmail.com>
References: <20260621035841.56194-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 04:09:16 +0000
Message-Id: <20260621040917.42E531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] udf_table_prealloc_blocks() and udf_table_new_block() ignore the r=
eturn value of udf_delete_aext(), leading to double-allocation on error.
- [High] udf_delete_aext() leaks two buffer_head references on early return.
--

commit b35154de447cbd2ab36c556abd7be97822502a4b
Author: Deepanshu Kartikey <kartikey406@gmail.com>

udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks

This commit fixes a recursive deadlock on s_alloc_mutex by modifying
udf_delete_aext() to return the freed block via an out-parameter.
Callers can then free the block after dropping the mutex.

Link: https://syzkaller.appspot.com/bug?extid=3D6a680377e13041c19d50

> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index cc6dc6e1d84de..30cec56001491 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c

[ ... ]

> @@ -541,7 +543,7 @@ static int udf_table_prealloc_blocks(struct super_blo=
ck *sb,
>  			udf_write_aext(table, &epos, &eloc,
>  					(etype << 30) | elen, 1);
>  		} else
> -			udf_delete_aext(table, epos);
> +			udf_delete_aext(table, epos, &freed);

[Severity: High]
This is a pre-existing issue, but does ignoring the return value of
udf_delete_aext() here risk a double-allocation?

If udf_delete_aext() returns -1 due to an error, the block remains in
the unallocated space table. Since udf_table_prealloc_blocks() proceeds
as if the deletion succeeded, could a subsequent allocation find and
allocate the exact same block?

[ ... ]

> @@ -643,12 +649,14 @@ static udf_pblk_t udf_table_new_block(struct super_=
block *sb,
>  	if (goal_elen)
>  		udf_write_aext(table, &goal_epos, &goal_eloc, goal_elen, 1);
>  	else
> -		udf_delete_aext(table, goal_epos);
> +		udf_delete_aext(table, goal_epos, &freed);

[Severity: High]
This is a pre-existing issue, but the same return value behavior happens
here in udf_table_new_block() as well. Does this code need to handle
the case where udf_delete_aext() returns an error to avoid corruption?

> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 67bcf83758c8f..2c8647e0c9131 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c

[ ... ]

> @@ -2328,7 +2328,8 @@ static int udf_insert_aext(struct inode *inode, str=
uct extent_position epos,
>  	return ret;
>  }
> =20
> -int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
> +int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
> +			struct kernel_lb_addr *freed)
>  {
>  	struct extent_position oepos;
>  	int adsize;

[Severity: High]
This is a pre-existing issue, but does the early return path in this
function leak buffer_head references?

At the start of udf_delete_aext(), two references to epos.bh are acquired:

if (epos.bh) {
        get_bh(epos.bh);
        get_bh(epos.bh);
}

However, if the initial extent traversal fails shortly after:

if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1) <=3D 0)
        return -1;

This early return path does not appear to call brelse() to release the
acquired references, which could pin the buffer in memory and prevent
unmounting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621035841.5619=
4-1-kartikey406@gmail.com?part=3D1
