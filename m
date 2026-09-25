Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033946C84F;
	Fri, 25 Sep 2026 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336739; cv=none; b=lotcaF80ylvFSwxqVoOFtJA0quYbDUquasXyVeHfaVGaOMHjcbxhbPpHl+PCK9XGw04ZI8ErqjASNrxVM8EyjMoq8beF9D7KX1NYFFT0rLYgZIzPt21+p8lDAV3C28zoulAFfRQKuHN47WKT63CWE/6SlMyjP2AriJjSkK7YeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336739; c=relaxed/simple;
	bh=KbZ9z5kUj1gA84Sz8eSQcbh3XE/aR5nfgFSgBfM2HNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWzHe2hJ+KbTtHxvaIWn+07+PlRZkicqpQNMdk9J+lBez6zG0JckWk5LuAYpUnX3oWyPHu6u3mh6eI5v3eh7QZjkIGTiUt9afIYAo4O/De9pLNN3lAmJ5EvBQgEiNPGIjj2DlFknqxFbXueVzIf7nTLgb1UY9xDXYiRnraZ66Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF0VlzPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF0VlzPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260121F0089F;
	Fri, 25 Sep 2026 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336736;
	bh=YIokY/9DYF5oTq2o6MqnDnLsIn0aLDZHZN6VRNpa95U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PF0VlzPHA3I1eYcdRgsbnyU5a3xwc0qLE1RMdp0VSOJMc4B1U9PjkNJamAiZWGH6T
	 NcUwYQtLdYyjDA1p0NskLrScjOhcJdhDTlxnLjUxRmRYP00ubDJD2+2ynauR//wS88
	 A/Sma6Zksb+74tFZ2hw9HTJXIHbMfX6e3a176iEmf1ppe6GWdTznqwQteIXdalTcxe
	 XmywiGU3sJQV9SXEjpl0DEIUoxKDsU6WqkypUu9p3HpOwig5yBiAab2UNA6vhDZMdX
	 Ww51iiYpENJ/ecNU2eE2phKJNaQKB/cLOTzI+rMZmOT2P6zzaWKd4rKIUKeMcLHa3b
	 YABBIkaXkfD+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] efivarfs: add nostatfs mount option to skip
 QueryVariableInfo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prashant Singh" <singhpra@juniper.net>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260925113145.7396-1-singhpra@juniper.net>
References: <20260925113145.7396-1-singhpra@juniper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:45:35 +0000
Message-Id: <20260925114536.260121F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] efivarfs: data race in efivarfs_show_options() on opts->nostatfs
--

commit 33ecb04473d9adc8fe8bcd4b68acea9d071545b7
Author: Prashant Singh <singhpra@juniper.net>

efivarfs: add nostatfs mount option to skip QueryVariableInfo()

QueryVariableInfo() is an EFI runtime service that, on some firmware,
takes tens of milliseconds and runs with preemption disabled, stalling
the CPU that services it. efivarfs_statfs() calls it (rate-limited since
commit b2326338dc68 ("efivarfs: Rate limit statfs() handler")) to report
the variable-store used/available capacity, so any statfs(2) -- e.g.
every "df" -- can inject that stall into unrelated latency-sensitive
workloads on the same CPU.

Add a negatable "nostatfs" mount option: with nostatfs, statfs(2) skips
QueryVariableInfo() and reports zero used/available; with statfs it
reports the capacity as before.

> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 8d33f11db2a1b..d2e1f31a72d1e 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -74,6 +74,15 @@ static int efivarfs_show_options(struct seq_file *m, s=
truct dentry *root)
>  	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
>  		seq_printf(m, ",gid=3D%u",
>  				from_kgid_munged(&init_user_ns, opts->gid));
> +	/*
> +	 * Always show nostatfs (it makes statfs() report zero capacity, which
> +	 * is otherwise surprising); only show statfs where it is not the
> +	 * default, i.e. on PREEMPT_RT.
> +	 */
> +	if (opts->nostatfs)

[Severity: Low]
Does this code risk a data race and potential KCSAN warning?

Since opts->nostatfs can be updated concurrently by efivarfs_reconfigure()
using WRITE_ONCE(), reading it here without READ_ONCE() could result in
undefined behavior.

> +		seq_puts(m, ",nostatfs");
> +	else if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		seq_puts(m, ",statfs");
>  	return 0;
>  }

[ ... ]

> @@ -402,11 +421,17 @@ static int efivarfs_get_tree(struct fs_context *fc)
> =20
>  static int efivarfs_reconfigure(struct fs_context *fc)
>  {
> +	struct efivarfs_fs_info *sfi =3D fc->root->d_sb->s_fs_info;
> +	struct efivarfs_fs_info *new_sfi =3D fc->s_fs_info;
> +
>  	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
>  		pr_err("Firmware does not support SetVariableRT. Can not remount with =
rw\n");
>  		return -EINVAL;
>  	}
> =20
> +	/* statfs() reads nostatfs locklessly (no s_umount); pair with WRITE_ON=
CE. */
> +	WRITE_ONCE(sfi->mount_opts.nostatfs, new_sfi->mount_opts.nostatfs);

[Severity: Medium]
This is a pre-existing issue, but does this function silently discard newly
parsed uid and gid mount options during a remount?

It appears that efivarfs_reconfigure() only copies the nostatfs option into
the active superblock context, ignoring any changes to the uid and gid
options that were parsed into new_sfi.

> +
>  	return 0;
>  }
> =20
> @@ -524,8 +549,19 @@ static int efivarfs_init_fs_context(struct fs_contex=
t *fc)
>  	if (!sfi)
>  		return -ENOMEM;
> =20
> -	sfi->mount_opts.uid =3D GLOBAL_ROOT_UID;
> -	sfi->mount_opts.gid =3D GLOBAL_ROOT_GID;
> +	if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> +		/* Preserve options not respecified on remount. */
> +		struct efivarfs_fs_info *old =3D fc->root->d_sb->s_fs_info;
> +
> +		sfi->mount_opts.uid =3D old->mount_opts.uid;
> +		sfi->mount_opts.gid =3D old->mount_opts.gid;

[Severity: Medium]
This is a pre-existing issue, but is this intended to carry over the uid and
gid options so they can be modified by the parser?

Because efivarfs_reconfigure() never applies the parsed uid and gid back to
the live superblock, the preservation here acts as dead code. Administrators
who run "mount -o remount,uid=3D1000" will find their requested ownership i=
gnored
when creating new variables.

> +		sfi->mount_opts.nostatfs =3D READ_ONCE(old->mount_opts.nostatfs);
> +	} else {
> +		sfi->mount_opts.uid =3D GLOBAL_ROOT_UID;
> +		sfi->mount_opts.gid =3D GLOBAL_ROOT_GID;
> +		/* QueryVariableInfo() stalls the CPU; default nostatfs on PREEMPT_RT.=
 */
> +		sfi->mount_opts.nostatfs =3D IS_ENABLED(CONFIG_PREEMPT_RT);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925113145.7396=
-1-singhpra@juniper.net?part=3D1
