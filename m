Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372965;
	b=fWIzj79fvExaOYA+WzWZdmZNYck+zLEGPUDfoYGE+6JffnmToEcKYCKqqCz7UYoWMYwL
	 VNhHq607jj2TY/qxCBCYe30KFf4yFERK8T7gGSvAjDkj2K0SVybnB9t4logGNF/HVVN0t
	 WgTCbb87Kyz9Ofme2pnalsVj3xV5e46XHMnfEk+UgEpRafZ/znKpQqpGr/pTvXpTZYpA4
	 N07qTIH0HbH6wY37ytCoZ95rSZkKfu+m3jFhZzBE7GG1vJVN8V/yPf8IY+YQtyQYlTy0W
	 e/Pk8hsxjyhGlf/V1aL6hXxCJKl4ohuMHSgnsgt2Y4r9cWkedbwzc0KPfJFhW+vwQcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RDCP7rk82BGrM7x9CQ1RKGUhx+ThvlLUaUeIi9pEWDk=;
	b=vGerl7Lruq7x33ACY6EuWc9h7ITn9xDVXuFr2rYrGb+esumK4Jrpufb2ARbZ/3Hqxfvi
	 LGKj/rNgTpLH8RWf1XesoYXjV2MXE1E8GwSZ+PziVxnZCG+597LjIWDQS0WE3t6KuktXg
	 gCMU6wdYAsZ+R9GM5wrxpBZvcPUydvQeaI7kY0JmeOeGlO/pBxrICjlotFRL4tCzaZQGm
	 dAPJ/3kee7oydaLMM/UR9ZwvlfrKdjYnX6fLUNER5hc+zbIUN/6pSDRB4czhnys4lTCoz
	 H8kNyjf1yJnsj7jmbz9/5S/8X1wfWf23JMuoEU4YuWgjAVSjL63qE4dsu1g1HPQ0egA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMRmW9ps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F32606A32C;
	Sun, 22 Nov 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMRmW9ps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBDB1F000E6;
	Sun, 22 Nov 2026 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795372965;
	bh=RDCP7rk82BGrM7x9CQ1RKGUhx+ThvlLUaUeIi9pEWDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMRmW9psoOJIt3b5U2ZpEBZSwHtTIfujlqkKgK0s2pSfG79JEEwl+SH2pGDf0inxp
	 ESb66o3wbBvwoiP4IvjTAq4Kwp8rWH5VktQ6IYoMvVPE4vyectqH3O4zwgmitRTW6L
	 2soERMCbjgrGL2p78yNVWNLJzx4/Td/R3Q9C1wIRKTMDwsOvT2JGw/RfpaHsLHGVJ3
	 PLonTMNXG0QW3FcJLnDoUhp1i4EfMAXDCuO1Sg4KkPOKHHavsKAjo04cUCKEp/HFvn
	 uV6kda7bOgS6rry60kGHEB4y+VlavpoXUkmsvG+1te5AmP8gEb8/gP36OlvFWoRWCM
	 VMM+BqsYw7vLg==
Message-ID: <sashiko-outbox-228188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] softirq: Limit the BH count warning to RT BH lock users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <cyyzero16@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <d9554bee441d2c763ef8d61e966a7a471915bbee.1795372382.git.cyyzero16@gmail.com>
References: <d9554bee441d2c763ef8d61e966a7a471915bbee.1795372382.git.cyyzero16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 18:42:44 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] softirq: missing Fixes trailer for false-positive BH count
  warning fix
--

commit aff1deb32f25d2d4caa853499ddafd50802def5a
Author: Yiyang Chen <cyyzero16@gmail.com>

> softirq: Limit the BH count warning to RT BH lock users
>
> __local_bh_disable_ip() warns if a non-preemptible task first disables
> BHs while the per-CPU BH count is nonzero. Without the RT BH lock,
> this check can turn off lock debugging on a valid call sequence.
>
> With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=3Dn, the following sequence is valid
> for two tasks on the same CPU.
> Both tasks call the BH helpers with IRQs enabled. The per-CPU BH count
> starts at zero.
>
>   Task A                          Task B
>   ------                          ------
>   local_bh_disable()
>     softirq_ctrl.cnt +=3D SOFTIRQ_DISABLE_OFFSET
>     current->softirq_disable_cnt +=3D SOFTIRQ_DISABLE_OFFSET
>   <preempted by B>
>                                   preempt_disable()
>                                   local_bh_disable()
>                                     B's softirq_disable_cnt is zero
>                                     preemptible() is false
>                                     WARN on nonzero softirq_ctrl.cnt
>                                     softirq_ctrl.cnt +=3D SOFTIRQ_DISABLE=
_OFFSET
>                                     current->softirq_disable_cnt +=3D SOF=
TIRQ_DISABLE_OFFSET
>                                   local_bh_enable()
>                                   preempt_enable()
>   <resumes>
>   local_bh_enable()
>
> The warning relies on the per-CPU BH lock serializing BH-disabled
> sections on the same CPU. With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=3Dy, A
> still holds that lock when B runs. Since B is non-preemptible, it skips
> the lock acquisition. The nonzero count then exposes B entering the
> section while A holds the lock.
>
> With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=3Dn, there is no BH lock for B to
> bypass. The same nonzero count simply records A's active BH-disabled
> section, which may legitimately overlap B's.
>
> Guard the warning with CONFIG_PREEMPT_RT_NEEDS_BH_LOCK for as long as
> the lock is optional. If the lock is removed, as discussed earlier,
> the check can go away with it.
>
> Link: https://lore.kernel.org/lkml/20260310115534.3477871-1-jackzxcui1989=
@163.com
> Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>

[Severity: Low]
This fixes the warning left unguarded when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK
was introduced.  Should this include:

  Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREE=
MPT_RT")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d9554bee441d2c763ef=
8d61e966a7a471915bbee.1795372382.git.cyyzero16@gmail.com?part=3D1
