Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051D34B40F;
	Mon, 28 Sep 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628441; cv=none; b=PtquPll/Jz8Xr3EVsHkdKgc35cMKCYuXtbxPEfMRTueNYh69vG+tluxLChAKsaA57acVFXbdu8xjT/vt11fdzD2MuDpDmmM3lro+1PtKkgnEBXjGkXeX25ScD1TyNJkAY/vUIFMCQgzPScCQaDUKEtm9IK5Dwlcl+Xtg6eKkodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628441; c=relaxed/simple;
	bh=MXTODTCiof2pj1Dx8x4iCAGpUERSPRsb3EtuwuKH3Jw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnyxVSG0YrGB+sXKAEYhJzn4wJp2kVDaABTPsSoBeixN0zAkhLV20PP8SgDsd2xTM3ieIAvZe+3rglYxqHnuUsnXUXPMryKQIfgtnl2pxRlG/Eli9BmpvREmhu6Ki4OqDUZHcDOor4aRIoe19Csl6bEYGbXFyH4QCW8ZliKWHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYrWnS3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYrWnS3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290F01F000FF;
	Mon, 28 Sep 2026 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790628440;
	bh=kNGW/aJo/8KVU5RVmR9X3v3Tq5wwTNCJL/F5kpu+ED8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYrWnS3hyBU9v0W8WqdsQbGI+Fabq64xejCMytXTSHO8Y83Wz6+n/01cUfXAQGx1o
	 06LNrwxgzEja6MqQEvj6vWToIxt+mutRfyit/qG0/gD8m55Hh2KH9KGywNjC3fpJus
	 137EVNuVfyr4Sf3+SVCfB7ktzHGWb8Qh9kv+P0BDOZ+vdEJTzd6pCWQaM59Md7aM10
	 BgnVDQNgZsPsK/6ab6VVDAtmTTxUBEkm2x2nNgQO8mVDZyceRjffYvyayE5UlE1hw2
	 A6Eu7oBjsHm7ahYfJdpnvvfa0h0Un2Rg6KPKy1/h6U25E/BadONYybfp9J47viGYzI
	 RCZQvQudqTNSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] efivarfs: add nostatfs mount option to skip
 QueryVariableInfo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prashant Singh" <singhpra@juniper.net>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260928203445.72318-1-singhpra@juniper.net>
References: <20260928203445.72318-1-singhpra@juniper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 20:47:19 +0000
Message-Id: <20260928204720.290F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] vfs: missing READ_ONCE() for opts->nostatfs in efivarfs_show_option=
s()
--

commit 8539129e21537b2431de520ca79339783ffada2d
Author: Prashant Singh <singhpra@juniper.net>
Subject: efivarfs: add nostatfs mount option to skip QueryVariableInfo()

This commit adds a negatable "nostatfs" mount option to efivarfs. It skips
the EFI QueryVariableInfo() call during statfs(2), which can take tens of
milliseconds and run with preemption disabled. The option can also be toggl=
ed
on a live mount via remount.

> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 8d33f11db2a1b..efeada6e314f4 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -74,6 +74,9 @@ static int efivarfs_show_options(struct seq_file *m, st=
ruct dentry *root)
>  	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
>  		seq_printf(m, ",gid=3D%u",
>  				from_kgid_munged(&init_user_ns, opts->gid));
> +	/* Absence of nostatfs means statfs() reports real capacity. */
> +	if (opts->nostatfs)
       ^^^^

[Severity: Low]
Is a READ_ONCE() needed here?

This plain C read of opts->nostatfs in efivarfs_show_options() can race with
the concurrent WRITE_ONCE() in efivarfs_reconfigure() during a remount.=20

A userspace process reading /proc/mounts calls efivarfs_show_options() hold=
ing
only namespace_sem for read, while a concurrent mount -o remount calls
efivarfs_reconfigure() holding only sb->s_umount for write. Because no comm=
on
lock serializes these two paths, missing the READ_ONCE() here could lead to=
 a
KCSAN data race splat.

> +		seq_puts(m, ",nostatfs");
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928203445.7231=
8-1-singhpra@juniper.net?part=3D1
