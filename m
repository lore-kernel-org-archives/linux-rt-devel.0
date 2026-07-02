Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A3347FFE;
	Thu,  2 Jul 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010169; cv=none; b=NEaByYYjylVnn1278GhkP/0Uvq5HmF14/FGLmGPj8aR55rms2xSm8ZxNhOlHSmHGe5sDRzJFnc7rFSCF5WFNphg1o0PzksStK4FL07Q/b1fYoD+Jt4Qw6k9RcXbo0lEl13XHOnN8mRR03F1aQyFI3z5Euq1mZPb+/KOXjLdKFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010169; c=relaxed/simple;
	bh=U2myUqy16oUUPVTKif/mYu0p4OnOwfNmPij0yBGFDvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEbkyxDKYWIPjsroxsIRmJv+Mr7tX0FXi1lnh4dMZj33sN2uyQo2afth6QrfSEnvcZtuq+CRTJvZj2oUTdq5egwQ/0Yh4F7cVT0ihj1WqT0xNEpkJUh+cg+cc5kLcMSiSo5MaPzAEdB0uj0w/k//hZq58IQEs4CSj+enX2JJIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC3osl9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC3osl9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0207A1F00A3A;
	Thu,  2 Jul 2026 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010168;
	bh=7Ck9clGNisFN58caa9TILspqcMIyye99QDgE9l16a+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UC3osl9XvUh0QFeB8nUNSXUVN7NTgQaVfsNWeqW6RIUTPPwaikrJjuqjr75/gD6rh
	 Hny8shss+R8zyLm4OIfxC7tcQOd0wJomRhgt2BjWR6a7QnKLHpyvlj4nF1NF4VYe6H
	 7bFFW3kkKEJcWgvOTiDB3if5A9o9kfjcvA9ZF1hBlpzanbrJTIyaZQfS2V61+qRCuM
	 paPcftTyzBt6qvj7vxKPf1LLIJQQouGhtnLS9GIi+qxORfeseBxuXAiIZyrO/k2nJn
	 i9sn+qt7A1l+boF5NYhQ7ts/R6I54tXj5pa/MbAxhm0j1SQRsab6JF3SJreQ18H3Z8
	 zWwtdRX5TbwAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:36:07 +0000
Message-Id: <20260702163608.0207A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Garbage collector is no longer scheduled when creating new infligh=
t FDs, leading to permanent cycle accumulation and -ETOOMANYREFS failures i=
n isolated environments.
--

commit 506189bd29f8ad56f5d9e51f3e0216203ebad5ec
Author: Nam Cao <namcao@linutronix.de>

af_unix: Do not wait for garbage collector in sendmsg()

This patch removes the garbage collector scheduling and waiting from the
sendmsg() path for AF_UNIX sockets. It aims to prevent priority inversion
by relying on RLIMIT_NOFILE limits and asynchronous garbage collection.

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e25266..f180c59b3da9d 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>  	if (!fpl->edges)
>  		goto err;
> =20
> -	unix_schedule_gc(fpl->user);
> -

[Severity: High]
Does this removal prevent the garbage collector from running when a process
creates isolated socket cycles?

If a process continuously creates socket cycles (e.g., passing FDs to each
other) and closes its local FDs, the sockets reference each other in their
receive queues, so their file reference counts will not reach zero.

Because the refcounts do not drop to zero, unix_release_sock() is never
triggered. By removing unix_schedule_gc() from unix_prepare_fpl() here,
unix_release_sock() is left as the only trigger for garbage collection.

This could allow the inflight count to accumulate indefinitely until it
hits RLIMIT_NOFILE, causing subsequent sendmsg() calls to fail with
-ETOOMANYREFS and permanently leaking the network namespace unless an
unrelated AF_UNIX socket is closed system-wide.

>  	return 0;
> =20
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782922354.gi=
t.namcao@linutronix.de?part=3D1
