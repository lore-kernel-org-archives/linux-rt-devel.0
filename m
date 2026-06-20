Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0891A7264;
	Sat, 20 Jun 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781943628; cv=none; b=bgJ3LyXY2o+pjXsCasTMk5haqX54vJZatvOZz700hLlWjZKg1aQWCQbP72tsJ2HtKMP7ZXpRlaHe6zKPr3NfFeCrpBxFR4h7g4zjG6eiW8hDFMQExiSoryyFVMw5wJ5iZH2Q9iYsVZmGhMWyy/epLhLoOL2jOKOFxLjyzZjCybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781943628; c=relaxed/simple;
	bh=V6IHdpq4AZOLdpnbz6w7caRKMusdS32bKN5PKyetqfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ttibd8KixmSt3Vxg0DD3SE91yj3Yhe60XlFLm2OTPUh/YyodggzrS1oq5e/s1ybXDRi9wBEPyP4pw+/KjTSVgUjOc4QGLPrf+Vj+cAsYTGUid8FSYdqbt05EiFCA5JpaA/whdat1zkEqJvxZM/ejLJVsT/6T+UcwkTwtSoZl1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9fpQtMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9fpQtMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784E51F000E9;
	Sat, 20 Jun 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781943627;
	bh=WhHUWskBbABQj0J4oG6lnHCQeOzIW3XHx9VYJy/Flko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9fpQtMKIi8ZuxhqoSAs8LoQ6uJ1naAKJp2qTTw/R+FM+aSnxbq/zdHjq0TPoo18f
	 hb/MjcojHuP3Z/ZG+lAdlxWQbvVRek8VCgoB70C/DwKuNw33DBF0mCngwp88jKPxtt
	 oB1VDKSTlOIryN+waXu3dXCxkuLRZ7/P8lHc8FltF0ghi4wiCj1SGIPs9Efek7Zwwo
	 FjAbS9PLPDiYHtR9f6Pyy4+ogF8aUeN6XAkPc5DUwkQLRQmSXew6ImbN+TZe7jBy3w
	 5EVr/5NiY5GQ8kmSMbpYhU8Jwm2/Fo4lCYEWmSASYI/LKJ72391D9Q8X0wuN917wac
	 jvE6l2NEr1Vbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ocfs2: fix deadlock in dio write orphan cleanup path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260620080802.35165-1-kartikey406@gmail.com>
References: <20260620080802.35165-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 08:20:26 +0000
Message-Id: <20260620082026.784E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch completely fails to resolve the AB-BA deadlock between t=
he write path and the orphan recovery path, as the exact same lock dependen=
cy is immediately recreated.
- [High] The identical lock dependency cycle (A -> B -> D) exists unmitigat=
ed in the orphan addition path.
- [High] Directory `i_rwsem` operations use the wrong subclass, violating V=
FS lock ordering rules and hiding parent-child deadlocks.
--

commit a3ea3ef9d81bdb971acfa026b14e772f33af54fa
Author: Deepanshu Kartikey <kartikey406@gmail.com>

ocfs2: fix deadlock in dio write orphan cleanup path

This commit attempts to fix an AB-BA deadlock in the direct IO orphan clean=
up
path by releasing the file's cluster lock before calling
ocfs2_del_inode_from_orphan(). It passes NULL for di_bh to signal the
function to acquire its own lock.

Closes: https://syzkaller.appspot.com/bug?extid=3Dce129763ce7d7e914739

> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 6ec198bdab121..095cb3e44c65e 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c

[ ... ]

> @@ -2371,17 +2372,25 @@ static int ocfs2_dio_end_io_write(struct inode *i=
node,
>  		ocfs2_commit_trans(osb, handle);
>  unlock:
>  	up_write(&oi->ip_alloc_sem);
> +	/*
> +	 * Release the cluster lock and di_bh BEFORE calling
> +	 * ocfs2_del_inode_from_orphan(). That function will acquire
> +	 * inode_lock(orphan_dir_inode) which would cause an AB-BA
> +	 *  deadlock with recovery paths that hold orphan_dir lock
> +	 * before acquiring the file inode lock.
> +	 */
> +	orphaned =3D (!ret && dwc->dw_orphaned);
> +	ocfs2_inode_unlock(inode, 1);
> +	brelse(di_bh);
> +	di_bh =3D NULL;
> =20
> -	/* everything looks good, let's start the cleanup */
> -	if (!ret && dwc->dw_orphaned) {
> +	/* everything looks good, let's start the orphan cleanup */
> +	if (orphaned) {
>  		BUG_ON(dwc->dw_writer_pid !=3D task_pid_nr(current));
> -
> -		ret =3D ocfs2_del_inode_from_orphan(osb, inode, di_bh, 0, 0);
> +		ret =3D ocfs2_del_inode_from_orphan(osb, inode, NULL, 0, 0);
>  		if (ret < 0)
>  			mlog_errno(ret);
>  	}
> -	ocfs2_inode_unlock(inode, 1);
> -	brelse(di_bh);
>  out:

[ ... ]

> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 1277666c77cd2..25bbe2a9776ef 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -2712,10 +2712,21 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_supe=
r *osb,
>  {
>  	struct inode *orphan_dir_inode =3D NULL;
>  	struct buffer_head *orphan_dir_bh =3D NULL;
> -	struct ocfs2_dinode *di =3D (struct ocfs2_dinode *)di_bh->b_data;
> +	struct ocfs2_dinode *di;
>  	handle_t *handle =3D NULL;
>  	int status =3D 0;
> +	struct buffer_head *local_di_bh =3D NULL;
> =20
> +	if (!di_bh) {
> +		status =3D ocfs2_inode_lock(inode, &local_di_bh, 1);

[Severity: High]
This is a pre-existing issue, but is the AB-BA deadlock between the write
path and the orphan recovery path truly resolved?

When di_bh is NULL, this immediately reacquires the exact same
ocfs2_inode_lock on the file inode (Lock B) before the orphan directory's
VFS lock (Lock D) is acquired later in this function:

fs/ocfs2/namei.c:ocfs2_del_inode_from_orphan() {
    ...
    inode_lock(orphan_dir_inode);
    ...
}

Since the lock acquisition order remains exactly the same (B -> D) as it
was before the patch, and the recovery path acquires these locks in the
reverse order (D -> B), doesn't the deadlock cycle remain unmitigated?

Also, as a related pre-existing issue, couldn't the identical lock
dependency cycle (A -> B -> D) still occur unmitigated in the orphan
addition path?

During direct IO writes, ocfs2_dio_get_block() calls
ocfs2_add_inode_to_orphan() while holding the file's VFS lock (Lock A).
Inside ocfs2_add_inode_to_orphan(), the file's cluster lock (Lock B) is
acquired:

fs/ocfs2/namei.c:ocfs2_add_inode_to_orphan() {
    status =3D ocfs2_inode_lock(inode, &di_bh, 1);
    ...
    status =3D ocfs2_prepare_orphan_dir(osb, &orphan_dir_inode,
                                      OCFS2_I(inode)->ip_blkno,
                                      orphan_name,
                                      &orphan_insert,
                                      true);
}

This calls ocfs2_prepare_orphan_dir(), which acquires the orphan
directory's VFS lock (Lock D) via inode_lock(). This seems to establish
the exact same A -> B -> D deadlock cycle against the recovery path.

Finally, this is a pre-existing issue, but might the use of inode_lock()
on the orphan directory violate VFS lock ordering rules?

When modifying a directory, the VFS requires acquiring the directory's
i_rwsem with subclass I_MUTEX_PARENT. In ocfs2_del_inode_from_orphan()
and ocfs2_lookup_lock_orphan_dir(), the default inode_lock() is used
instead:

fs/ocfs2/namei.c:ocfs2_del_inode_from_orphan() {
    ...
    inode_lock(orphan_dir_inode);
    ...
}

Because the caller already holds the file's inode_lock (also subclass 0),
acquiring the orphan directory's lock using subclass 0 can create a
lockdep AA self-deadlock or cycle warning. Furthermore, taking a child's
lock before its parent directory's lock intrinsically violates the VFS
hierarchy (I_MUTEX_PARENT -> I_MUTEX_NORMAL). Should this be using
inode_lock_nested(..., I_MUTEX_PARENT) instead?

> +		if (status < 0) {
> +			mlog_errno(status);
> +			return status;
> +		}
> +		di_bh =3D local_di_bh;
> +	}
> +
> +	di =3D (struct ocfs2_dinode *)di_bh->b_data;
>  	orphan_dir_inode =3D ocfs2_get_system_file_inode(osb,
>  			ORPHAN_DIR_SYSTEM_INODE,
>  			le16_to_cpu(di->i_dio_orphaned_slot));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620080802.3516=
5-1-kartikey406@gmail.com?part=3D1
