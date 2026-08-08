Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721E367B85;
	Sat,  8 Aug 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195314; cv=none; b=Qyo32FxCUiCM8z5i7jVlCWdKf+PQD3Yc8+E4xzgB42RoO8mu8AC9cT/hjn2yTkV0W83zIomr4j028syiAaZrR+qrNqCqxfsJcv1UHLAuqBTC+Nb4WNlG6aE+rOMsnVr9zeCgPByxhdA25/uvI7KrQRNKhjJc1jvis/Iz5XdW+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195314; c=relaxed/simple;
	bh=4pxYi9PeFdRyacXuINAYKWS0Vac6ld8bmR7orUVJLiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwn7o6fjH5gkM3blOiAQ4uuCq455STgy3m9bYnAxSd5pP/tcxhgHE9zG0vFuWx5AIP26VU1VaBfK9ETShi0MdXFua0l2Q8uOplevTxIW4ykFq6+soRt31IjrmOg4bME/PIrJlI8pswwliUFjyUHgun7KfLXBkddfpfiufrg0Sm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOMZoEYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOMZoEYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A231F000E9;
	Sat,  8 Aug 2026 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195312;
	bh=W0xfsWH4IcyVYPfjqKAExPdLT/LG2w9tyjRSo2pEROg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOMZoEYuO2IFdDbv1QvA6mbcZepDWdt0UNnEpZjUWc6pUSJNMRMCYWuu5MiyiI/8F
	 5p2QAZarbkW2ExgjV9bres/CDSo6FM8ZweH6ww5C0mmDzeNrNoRpNBpdQ84eOFI8WM
	 zbwI+ZgUYATxRtuRhCDUpVvpEbjoji3kWSV5h95irWhYNy6TITG2hM9SbHYyFrgbq3
	 de9DRe5M39t6jhE8yjvZX6qnmCCLOF9sGRc/TnxPeV6roeKWxRter+v7+Hc9roVdQv
	 fwGUbAYdp0/babtKPX/HaxnkxFngGsj7aO5I0W7/vnF33UDTlXP+673jbA9DP0rHNI
	 VhHrJMXakOEjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] samples: enhance hung_task detector test with
 rtmutex support
Reply-To: sashiko-reviews@lists.linux.dev
To: ruipengqi <ruipengqi3@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <4991cd8e1bbddb42a1fe31dde38f85d74ff1c4cc.1786193045.git.ruipengqi3@gmail.com>
References: <cover.1786193045.git.ruipengqi3@gmail.com>
 <4991cd8e1bbddb42a1fe31dde38f85d74ff1c4cc.1786193045.git.ruipengqi3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:21:51 +0000
Message-Id: <20260808132152.58A231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.owner =3D THIS_MODULE` in `struct file_operations` allow=
s the module to be unloaded while debugfs files are open, leading to a use-=
after-free on module unload. This problem wasn't introduced by this patch, =
but the patch replicates the flawed pattern.
--

--- Patch [2]: [PATCH v2 2/2] samples: enhance hung_task detector test with=
 rtmutex support ---
commit 1b388ec83d8aff9dc25159e4fe36a84b7c7583d7
Author: Ruipeng Qi <ruipengqi3@gmail.com>

samples: enhance hung_task detector test with rtmutex support

This commit extends the hung_task detector test module with an rtmutex test.
When CONFIG_RT_MUTEXES is enabled, it creates an additional rtmutex debugfs
file to allow testing hung-task reporting for rtmutex waits.

> diff --git a/samples/hung_task/hung_task_tests.c b/samples/hung_task/hung=
_task_tests.c
> index 0360ec916890b..87346d65f860a 100644
> --- a/samples/hung_task/hung_task_tests.c
> +++ b/samples/hung_task/hung_task_tests.c
[ ... ]
> @@ -116,6 +147,13 @@ static const struct file_operations hung_task_mutex_=
fops =3D {
>  	.read =3D read_dummy_mutex,
>  };
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/* File operations for rtmutex */
> +static const struct file_operations hung_task_rtmutex_fops =3D {
> +	.read =3D read_dummy_rtmutex,
> +};
> +#endif

[Severity: High]
This is a pre-existing issue, but this new rtmutex file operations struct (=
as
well as the existing mutex one above it) omits the .owner field.

Without .owner =3D THIS_MODULE, fops_get() in the debugfs open proxy does n=
ot
increment the module reference count. If a user opens the debugfs file and
concurrently unloads the module via rmmod, the module is successfully
unloaded because debugfs_remove_recursive() does not block merely open file=
s.

When the file is eventually closed, full_proxy_release() will unconditional=
ly
dereference real_fops->release. Since real_fops points to the unloaded
module's memory, can this trigger a use-after-free crash on module unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786193045.gi=
t.ruipengqi3@gmail.com?part=3D2
