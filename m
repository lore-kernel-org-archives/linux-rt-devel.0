Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDB2571DA;
	Sat, 19 Sep 2026 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789793406; cv=none; b=GU0D2YDj3dU2QVrsmgLz3wyLiRfHaXeS+9IHy2h7upWMbcPfijIZdiEawq8CDNvfRTv7Y9sLld2xYuAiyZP+uPoGR3YmCg5yvjOmpYTcmI8tiYdyU2M0WStsMD1vXkrbz9CQwVLOFO+xHfEQqlpF05V8a7qQOANwrOgKsuGw/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789793406; c=relaxed/simple;
	bh=DFuR8A/Zeo1+CXjLwjwvmtqoZRAs7Moh1J7VcXQJ9Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c2LoknE1b0IHX0EUL9rpK8Lr9Awo63nvTrUAetkVSVYPFo6KP2IHpBRk+q5WBlBYa+7SONvobbAZDSJzx7+IRAcRTTMNS16C8LtKctj0izCs0sWiDNogl0YbTSZBxEXXD9srUCCg9GIAC+q9SmoqSwpSMHJTJiykBo6e9aKbhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gircg6UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gircg6UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72D1F000FF;
	Sat, 19 Sep 2026 04:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789793405;
	bh=zf2e8IiHUj+K0o7bYRKKt+/cYJ93DQqEMSctgrbc/Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gircg6UFgrs63cjVPWRNLpkEKMIf6q3Mk+KbEsoXlyTBcMVDYabphrN8gZPWoKigd
	 Lfzdi86EJ5neV65uWnt011hXNyoE4zKd64wjgic6z66nCRvldnIVWayNGURKN/xySE
	 btNoeBye2L7o7Uoqxgl5tPDO+mxNTxSJfVq/7Yl7CjQsiAHN4R0HXkW63YZACQ2jkj
	 mjjXXcDcxZ0eX59DFi+BIVWkjqHedGityJ02m8uJ7UogMB1Yuzwwe06zQ0/Fw2+LsH
	 E2P+C3eYLIgI0Y2Ypkc1ugcaJGmNuGDRL7ZyENxIilg3gkfFIGUmSMwzwg6psYxzZ2
	 BLIKEcW7odP+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] efivarfs: add nostatfs mount option to skip
 QueryVariableInfo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prashant Singh" <singhpra@juniper.net>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260919044124.8268-1-singhpra@juniper.net>
References: <20260919044124.8268-1-singhpra@juniper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 04:50:04 +0000
Message-Id: <20260919045005.1D72D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] efivarfs: cannot disable nostatfs on PREEMPT_RT kernels
--

commit d9f40eeab38e7ccb1227aacdbea972e4b143d97c
Author: Prashant Singh <singhpra@juniper.net>
Subject: efivarfs: add nostatfs mount option to skip QueryVariableInfo()

This commit introduces a "nostatfs" mount option to efivarfs to skip calling
the slow QueryVariableInfo() EFI runtime service during statfs(). On kernels
built with CONFIG_PREEMPT_RT, this option is enabled by default to avoid
stalling the CPU.

Link: https://lore.kernel.org/all/20260917071600.5587-1-singhpra@juniper.ne=
t/

> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 8d33f11db2a1b..fbdaa4915d303 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
[ ... ]
> @@ -323,12 +331,13 @@ static int efivarfs_callback(efi_char16_t *name16, =
efi_guid_t vendor,
>  enum {
> -	Opt_uid, Opt_gid,
> +	Opt_uid, Opt_gid, Opt_nostatfs,
>  };
> =20
>  static const struct fs_parameter_spec efivarfs_parameters[] =3D {
>  	fsparam_uid("uid", Opt_uid),
>  	fsparam_gid("gid", Opt_gid),
> +	fsparam_flag("nostatfs", Opt_nostatfs),
>  	{},
>  };

[Severity: Medium]
Does this omit the ability to specify the inverse of the option?

Only the positive flag is registered with the parser here in
efivarfs_parameters, which means there is no way to explicitly pass a
negated option during mount.

[ ... ]
> @@ -350,6 +359,9 @@ static int efivarfs_parse_param(struct fs_context *fc=
, struct fs_parameter *para
>  	case Opt_gid:
>  		opts->gid =3D result.gid;
>  		break;
> +	case Opt_nostatfs:
> +		opts->nostatfs =3D true;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

[Severity: Medium]
Is there a way for users to explicitly request statfs to be enabled?

There is no corresponding case in efivarfs_parse_param() to set
opts->nostatfs =3D false (for example, via a "statfs" option).

[ ... ]
> @@ -526,6 +538,8 @@ static int efivarfs_init_fs_context(struct fs_context=
 *fc)
> =20
>  	sfi->mount_opts.uid =3D GLOBAL_ROOT_UID;
>  	sfi->mount_opts.gid =3D GLOBAL_ROOT_GID;
> +	/* QueryVariableInfo() stalls the CPU; default nostatfs on PREEMPT_RT. =
*/
> +	sfi->mount_opts.nostatfs =3D IS_ENABLED(CONFIG_PREEMPT_RT);
> =20
>  	fc->s_fs_info =3D sfi;

[Severity: Medium]
Since the flag is enabled by default in efivarfs_init_fs_context() on
PREEMPT_RT kernels, and the parser has no mechanism to clear it, does this
permanently lock administrators out of checking EFI variable capacity
via statfs() on those systems?

Would it make sense to define a negative flag using fsparam_flag_no() so
administrators can override the CONFIG_PREEMPT_RT default if they need to
monitor the capacity and are willing to accept the stall?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919044124.8268=
-1-singhpra@juniper.net?part=3D1
