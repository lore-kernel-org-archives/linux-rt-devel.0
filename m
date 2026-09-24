Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC03CF026;
	Thu, 24 Sep 2026 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220593; cv=none; b=PCfkUGLm7iXVRvZtqlV1DRMZLBXBw8jP83dQ5Dex/O1lLEi/g3YILoOHRsixupfvsWrN3Ib3uf3NmYvJ2Adsjgx3R3SZCoYfiKxVg0c8SyC2jUlhdurisfZUOCSDrfHC/zBzC5SdrreicPak1Of9K7ea6yRhFYJO1vu/T2k6lzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220593; c=relaxed/simple;
	bh=r4TlyA25aGbF0m/XVY+ntzz0BJITt+kvSyu/a4QqVag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YS+3TGHatLKcV05LyyRUft68RCakkwSafiXRQbRJtCmbzFpmtQ6+ejEM2OeYC/+BgUcvTELDLPOAiG6KybMCNY5kdLfzknzCeYaT/z2njd/allSXoMQ6GH8syUXYtnctcX+g0kwGKkb/SSLtCZ/VSzOQeG+3v6RvqOUXMQVgAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQFRu5Pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQFRu5Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A351F000FF;
	Thu, 24 Sep 2026 03:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220591;
	bh=KrA+d69psP1QciVnC5Bhs4nfFkeHvvAlkebCtl05aeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQFRu5PvkCLTgmVLdAdWnfL8IXnZ0Zbx+/uBgyEgrAOgkCzrtzdufFaHgEm25A5tV
	 B3vO1n6Z4Hx2HVrG01jEMG0VW4gHBYOJV3BKVbg061kbxtt0m8sE/QeP3wks7JCaZN
	 fpaX+iD6aK27hxl/IjqDBAI+QCMpR14rYZHy/xK1F/g2IyMNRMtAAAtpQLTI1639CC
	 +yN8ahdx09rjfduEgKr+X79MLay5BgNLdIpTvcYGKxHJSEsSbc/6SX5RV7yuqT9YDU
	 7peRbZREVgv/9n4d8bTAEWYPrPb8ooP39CU/y5Ey8iPpQwec5XwiI/lUDnCfa2dzDv
	 BK4LhzlilFSYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:29:50 +0000
Message-Id: <20260924032950.C2A351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: gen_estimator: unnecessary irq disable for non-existent har=
dirq reader
--

commit 9722f5db0aef7c6cb33fd991daa5c91e6188c2bb
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

net: gen_estimator: protect seqcount updates from hardirq readers

This commit modifies est_timer() to disable local interrupts instead of
just disabling preemption when updating the estimator sequence counter.
The commit message notes this is to prevent a spinning hardirq reader,
reproducing a lockdep warning via a test-only hardirq injection.

> diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
> index c34e58c6c3e66..6aba5916d7959 100644
> --- a/net/core/gen_estimator.c
> +++ b/net/core/gen_estimator.c

[ ... ]

> @@ -90,12 +91,12 @@ static void est_timer(struct timer_list *t)
>  	rate =3D (b_packets - est->last_packets) << (10 - est->intvl_log);
>  	rate =3D (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
> =20
> -	preempt_disable_nested();
> +	local_irq_save(flags);

[Severity: Medium]
Does this unnecessarily increase hardirq latency and CPU overhead by replac=
ing
a zero-overhead preemption disable (on non-RT) with an expensive hardware
interrupt disable?

The commit message explicitly states this was triggered by a test-only hard=
irq
injection. In a production environment, gen_estimator_read() is only called
from softirq or process contexts (such as netfilter hooks, TC actions, or
stats dumping), and never from hardirq context.

Since est_timer() executes unconditionally, this change appears to add
overhead to the fast path to protect against a state that is structurally
impossible in actual usage.

>  	write_seqcount_begin(&est->seq);
>  	est->avbps +=3D brate;
>  	est->avpps +=3D rate;
>  	write_seqcount_end(&est->seq);
> -	preempt_enable_nested();
> +	local_irq_restore(flags);
> =20
>  	est->last_bytes =3D b_bytes;
>  	est->last_packets =3D b_packets;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923032936.2020=
902-1-runyu.xiao@seu.edu.cn?part=3D1
