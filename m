Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056240F8D6;
	Fri, 10 Jul 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681022; cv=none; b=MkNsMJDpqxfDMcWv0FwJTTy/44Z9u/7Tr2C5Ss9Dt69rWBuPwich6KxmG/lCvbGzMnYS7OucYs43ekSz25ckjucRbhHOy7kdbvzCiam9XyKvNN9FsQjCSBfJDo63fRrXCtdP09JORSV2rBQ8doR/25gh1799aB+eQujhNx4Lxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681022; c=relaxed/simple;
	bh=4c81CBzUocB4XSeAbLvkLio2CY4yU4QNqh4rZAcf9lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5IHzFVq7+HiWc7Ol2wB5N9xddfMOPoHO1WdNKUTpsjP74gWoyE4cmUA0ipvOnIiZk7kHtaMqzPj8HxsF3NYyAnwExy96sFfxDKqdttpQzl/wR9RYB4gpuRz5CvBDAWwHYmA02uIcuBzsqoF26MO/imgct9zVKTMIDDeXwGTM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHbvC4DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHbvC4DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BDE1F000E9;
	Fri, 10 Jul 2026 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783681020;
	bh=Nq1r1vU42rLKgF9DtlFCxpvPkBnPy6qbqzJ02MIgE5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHbvC4DBXUTpIY8fM08TOndhIYFbvZ3ex7lcLDBZ43j04j7Q4TmM7PjmUEACNJVDL
	 h/joc8l77hVrTcI7bHEPnZ7dsSGiVR10p30vOX6To+AYlpYTP5QtEJESUpn/jiYhaQ
	 EONuOqCXkMXkZiL/Wr5cuWRD8aSRME3x+UkLjvb4/twWT6+PC7H2CbJqrK0H2XR2DZ
	 QhtXS+z+dx8hrw9kUAsVNj80JdB+aBj1q7lk2BcV6bXYhTmCBLcvQJflAarpdNoDjS
	 5MzLHz5BHhIerV7KPvXOSQJftqFJg7zRVktgAgmwhNmZ4zVvGpI0bRDnS8SV1akToj
	 eHRH8WYRx2AaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:57:00 +0000
Message-Id: <20260710105700.A5BDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `!can_spin_trylock()` safety check in `__free_frozen_pages()` =
is bypassed for allocations with order > `pcp_allowed_order()` and for isol=
ated pages, leaving them vulnerable to unsafe lock acquisition and potentia=
l memory corruption on UP systems or deadlocks on PREEMPT_RT.
--

--- Patch [1]: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP=
 ---
commit af22d8399ea9f942d20dfb24bc4e88e16f5fe2e1
Author: Brendan Jackman <jackmanb@google.com>

mm/page_alloc: don't spin_trylock() in NMI on UP
   =20
This commit updates the NMI and hardirq safety check in __free_frozen_pages=
()
to use can_spin_trylock(). It addresses an issue on UP systems where
spin_trylock() is unsafe in NMI context, which was missed on the free path.

Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19=
d3@google.com

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c97a86da2b9f..5fe1c11f919d7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, =
unsigned int order,
>  		migratetype =3D MIGRATE_MOVABLE;
>  	}
> =20
> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
> -		     && (in_nmi() || in_hardirq()))) {
> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {

[Severity: High]
This isn't a bug introduced by this patch, but since the goal is to prevent
unsafe lock acquisition, does this check need to be moved earlier in
__free_frozen_pages() in mm/page_alloc.c?

There are early returns earlier in __free_frozen_pages() that bypass this
safety check completely. For example, for large orders:

    if (!pcp_allowed_order(order)) {
        __free_pages_ok(page, order, fpi_flags);
        return;
    }

And for isolated pages:

        if (unlikely(is_migrate_isolate(migratetype))) {
            free_one_page(zone, page, pfn, order, fpi_flags);
            return;
        }

Both of these paths eventually reach free_one_page() (around line 1561), wh=
ich
unconditionally calls spin_trylock_irqsave() if FPI_TRYLOCK is set:

    if (unlikely(fpi_flags & FPI_TRYLOCK)) {
        if (!spin_trylock_irqsave(&zone->lock, flags)) {
            add_page_to_zone_llist(zone, page, order);
            return;
        }
    }

Could this lead to memory corruption on UP systems or deadlocks on PREEMPT_=
RT
if a high-order or isolated page is freed in NMI context via
free_frozen_pages_nolock() with FPI_TRYLOCK?

>  		add_page_to_zone_llist(zone, page, order);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-spin-trylo=
ck-followup-v1-0-affb5fe5ed00@google.com?part=3D1
