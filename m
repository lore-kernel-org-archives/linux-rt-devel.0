Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB523C50A;
	Sat, 20 Jun 2026 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781997957; cv=none; b=DCtt8tlYnoz+FJ362ntTM5HeUXxCjgW9RUytnJYusRZxhd7aT62xPlSBkbbQxtcZnACDsPu+6MShrb04vTUu1OLezUzutzIyWcdAbsRYElwIZ8g+xsEkdDLmu/hsfH3X6BdYASXBIJ31XAo/QVhxA2myDyoHzh9lSGG/KHkoMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781997957; c=relaxed/simple;
	bh=+d1wN5BJSl9c7+dj50c5cZajVucDM4Z1hZ2ETMmXbkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lg+y7pPO2GiMD8I39BCBweL7tpanHJPOaIAjBTlAi2Y30KpP6NFe33r4sWZR/QjiF+FUSlnacm8jG/EyTXK12A079CQQG8tAvUcHnU6ao6kZEXGZqsmPB2lnI4lFEgDzeHf4VB3t6KMaU3fSigSgE9sMRgZQ6B7Ov9eBpSCVcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itu6hpI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itu6hpI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7231D1F000E9;
	Sat, 20 Jun 2026 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781997955;
	bh=j1gAyMz0S2HB5lu+pP5nxY80fiTHsTjlFSWkyzsEZhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Itu6hpI4wZBP2FdlHiuC6o0/FeKm0/OHoosjDXq8gWfDRVb1Xxog9nWotoiLf3JR1
	 dW606wZa2iC9IyamwBZsXk2YN/iGhvkKuXFMP01EQGFWWg5bIf8bi9hxWL6DzjtYpU
	 orZmQBUoo/x6LqBZi+IQeKv8Lms5hg2GFGQ8TA0fZiFZWVHNe02CZ06MCdxaT5lSYo
	 xxphwsGEtdFQOu1BT//mxrvo0sqmeUIPTyTxPOuUTCMTz8rOG3kV79pq2dhKTzcn7Y
	 PGQYzFub+oH4f4c2z27hDwUkHV/72G42bzyrjEXIDJOr5ctQEuJKL/VxRMue+Ck8Pn
	 00soBUtjZu41w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ocfs2: use inode_lock_nested() for orphan dir
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260620231223.46588-1-kartikey406@gmail.com>
References: <20260620231223.46588-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 23:25:54 +0000
Message-Id: <20260620232555.7231D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incorrect assignment of the I_MUTEX_NONDIR2 subclass to the orphan=
 directory violates VFS semantics, introduces a new lockdep cycle during re=
name, and fragments lockdep tracking.

Pre-existing issues:
- [Critical] Unvalidated on-disk fields i_dio_orphaned_slot and i_orphaned_=
slot are used as array indices, leading to out-of-bounds memory accesses.
--

commit f1e102271ff71f1f4452e0af815188536b47c93e
Author: Deepanshu Kartikey <kartikey406@gmail.com>

ocfs2: use inode_lock_nested() for orphan dir locking
   =20
PREEMPT_RT's rtmutex PI chain walker warns about a lock dependency
cycle when inode_lock(orphan_dir_inode) is called while holding
inode_lock(file_inode):

[ ... ]

Closes: https://syzkaller.appspot.com/bug?extid=3Dce129763ce7d7e914739

> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 1277666c77cd2..4cfd7b3d3e1a4 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -2126,7 +2126,7 @@ static int ocfs2_lookup_lock_orphan_dir(struct ocfs=
2_super *osb,
>  		return ret;
>  	}
> =20
> -	inode_lock(orphan_dir_inode);
> +	inode_lock_nested(orphan_dir_inode, I_MUTEX_NONDIR2);

[Severity: High]
Does this violate vfs locking rules by assigning a non-directory lock class
to a directory? The orphan_dir_inode is a directory, so it expects a parent
lock class like I_MUTEX_PARENT.

Also, are we missing other locations that lock the orphan directory?
For example, in fs/ocfs2/inode.c:ocfs2_wipe_inode() and
fs/ocfs2/journal.c:ocfs2_recover_orphans(), we still call
inode_lock(orphan_dir_inode). Could using different subclasses for the same
inode corrupt lockdep dependency tracking?

[ ... ]

> @@ -2725,7 +2725,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super =
*osb,
>  		goto bail;
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but can the unvalidated on-disk value
di->i_dio_orphaned_slot lead to an out-of-bounds access?

A few lines above, we read the slot directly from the on-disk buffer:

    orphan_dir_inode =3D ocfs2_get_system_file_inode(osb,
            ORPHAN_DIR_SYSTEM_INODE,
            le16_to_cpu(di->i_dio_orphaned_slot));

If the on-disk slot value is maliciously crafted,
fs/ocfs2/sysfile.c:get_local_system_inode() will use it as an array
index for osb->local_system_inodes, leading to an out-of-bounds read.

Similarly, could this cause an out-of-bounds write in
fs/ocfs2/inode.c:ocfs2_check_orphan_recovery_state() when it increments
osb->osb_orphan_wipes[slot]?

> -	inode_lock(orphan_dir_inode);
> +	inode_lock_nested(orphan_dir_inode, I_MUTEX_NONDIR2);

[ ... ]

> @@ -2838,7 +2838,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *di=
r,
>  		goto leave;
>  	}
> =20
> -	inode_lock(orphan_dir_inode);
> +	inode_lock_nested(orphan_dir_inode, I_MUTEX_NONDIR2);

[Severity: High]
Could using I_MUTEX_NONDIR2 here introduce a new lockdep cycle during
file-over-file rename operations?

In the rename path, vfs_rename() uses lock_two_nondirectories() to lock the
target file with I_MUTEX_NONDIR2:

fs/inode.c:lock_two_nondirectories() {
    ...
    inode_lock_nested(inode2, I_MUTEX_NONDIR2);
    ...
}

If ocfs2_rename() then orphans the overwritten target file, it calls
ocfs2_prepare_orphan_dir(), which will now try to acquire the orphan
directory lock with I_MUTEX_NONDIR2. Could acquiring subclass 4 while
already holding subclass 4 trigger a 'possible recursive locking detected'
warning?

> =20
>  	status =3D ocfs2_inode_lock(orphan_dir_inode, &orphan_dir_bh, 1);
>  	if (status < 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620231223.4658=
8-1-kartikey406@gmail.com?part=3D1
