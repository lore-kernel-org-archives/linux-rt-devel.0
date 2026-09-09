Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EB3932C8;
	Wed,  9 Sep 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945531; cv=none; b=MDw9VTx+JNrONpz4J9IaehNodrdOkEJCvf/ZNYafMFV0IRVunDPYNFDh9JgiBghQ0W3dyFlHDLohOi+IbCagaIUEsR3tulUoVdZzzfU91rG71IvWvrQrQFMsKlXjQnOGX6HId/AIv8rqfRj0HhIiJkJ9+0QaESKVyBngPtonryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945531; c=relaxed/simple;
	bh=KwSbl26EqEwWgv+j7uuWj7a4V9mGws1cHFC/6noh00E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUXX90+L+gBc4OgOnObcgAYIRn4qPgmfdK3Xz1QOWjy+4oT+qvGC2ZPWAH4Sm8v1+WppTXiAYJ7Oq2GdJdoUIdgJhqhohKZv4AQVcK5IGdM6avXOKBNUmfhTp0njzXPo5FdJ5UzKi/S1suGQNUbG2V8yvjhKOPwnHZDbpRgJlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e76k5AlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e76k5AlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7F1F00A3D;
	Wed,  9 Sep 2026 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945530;
	bh=P3TZAUjGVCUtCyfHRRbjxWK8G4wN+GQqyq89GY7Q9O8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e76k5AlYmQ5D8gUgwPy14wq3Jh4dnLOVM2mJ0GJjFti+gxQQm6QxvBfwe/cABVZpG
	 lBpwbkuIlGTW9EQgnJYs0KP+058kpKK20kxtaN0KVhvt5BCzi9daVmoIalZPx6YcIV
	 5iU1KketOMcRthbsPc+4Tuffe118yhY3cVzwWZeiojjiNAhVnthUO5eBaqgJASj9mZ
	 G/Adr/ABvoCp812tJbCyKUNKIT+Mr3N1rmdOHXHQiezoldW23NOn/LORdxNhAp4IOA
	 oR0agkV52OOQn7G2PzTDz7VGiUO7fG8HhxJIe3Mkj2Un9ooxr5BEjaAqGKhDBkIFmw
	 JD94OGsDBgvTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fs/ntfs3: use d_instantiate_new() in
 ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
References: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:18:49 +0000
Message-Id: <20260909091849.C5D7F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `ntfs_init_acl()` fails, the error path skips the necessary cle=
anup for `ATTR_EA`, permanently leaking disk clusters allocated for non-res=
ident extended attributes.
--

commit 44a39faac2ebabd21da92b47785ce2d1e97401b0
Author: Christian Brauner <brauner@kernel.org>

fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot'=
s "WARNING in do_new_mount" saga

This commit fixes a bug where d_instantiate() was called on an I_NEW inode
before unlock_new_inode(). This caused lockdep lock owner corruption when
paths concurrently locked the directory. The fix switches to using
d_instantiate_new() and drops the trailing unlock_new_inode().

Closes: https://lore.kernel.org/6a9beced.a5e650b3.26d8a.000b.GAE@google.com

> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 56b4f6469a280..4ac26c80bd34f 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c

[ ... ]

> @@ -1917,9 +1917,6 @@ int ntfs_create_inode(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	if (!fnd)
>  		ni_unlock(dir_ni);
> =20
> -	if (!err)
> -		unlock_new_inode(inode);
> -
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does ntfs_create_inode()
permanently leak disk clusters if ntfs_init_acl() fails?

If ntfs_init_acl() returns an error, the error path jumps to out5:

fs/ntfs3/inode.c:ntfs_create_inode() {
    ...
#ifdef CONFIG_NTFS3_FS_POSIX_ACL
	if (!S_ISLNK(mode) && (sb->s_flags & SB_POSIXACL)) {
		err =3D ntfs_init_acl(idmap, inode, dir);
		if (err)
			goto out5;
	} else
#endif
    ...
}

Jumping to out5 bypasses the out6 label, which contains the essential
cleanup logic for ATTR_EA:

out6:
	attr =3D ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
	if (attr && attr->non_res) {
		/* Delete ATTR_EA, if non-resident. */
		struct runs_tree run;
		run_init(&run);
		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false);
		run_close(&run);
	}

out5:
	if (!S_ISDIR(mode))
    ...

If ntfs_init_acl() creates the first ACL (which allocates non-resident
clusters for ATTR_EA via ntfs_set_acl_ex -> ntfs_set_ea -> attr_set_size)
but fails on the second ACL (e.g. ENOMEM), the non-resident ATTR_EA is left
attached to the inode.

The error path then proceeds to out4, clearing RECORD_FLAG_IN_USE on the MFT
record. Later, when the inode is evicted and ni_clear() is called, it checks
is_rec_inuse(). Because the flag was cleared, ni_clear() skips calling
ni_delete_all(), which is the only other function capable of freeing
non-resident attribute clusters.

Could an unprivileged user repeatedly trigger this failure (e.g. by exhaust=
ing
memory) to systematically exhaust disk space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-work-ntfs3=
-d_instantiate_new-v1-1-2db697162ce8@kernel.org?part=3D1
