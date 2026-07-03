Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB132AAA0;
	Fri,  3 Jul 2026 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083324; cv=none; b=GUDhrYUdj70IUUiLsbw5qsfMmeLMq3Hg9gOwAdGsGuFNpkVDrWBoYZLyVOUEQW4RnYFUXpH3ixVbr9ZndfQ1iomUPk4xmcKi+5KOu4xbkbxuR2S12ayDR69JAuGTcOP4ERzDNhyTUbEaBnEZwZ2g+s1xbN9xGffVYF/uMMXwRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083324; c=relaxed/simple;
	bh=8SBT4OTdgj5e+dRtmVraOTcKGX0J2+C8UiEeMVM7sSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hcGGFPe8/dTBU6E3j9LZprdGlNvlNjbnSDTLL3AtUPv69g0L8YpUXtfWnMf4w1brAKvG0KRC2eX2WxGqb7RmtrgQfa/0RZXebUJiRfwIaOr3neFKUrLY0Cc+9Am1IBhXDBACfjqi6dzdRxK3MkoNIxTDv/3rThcZmtPLJwNDq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXeydxLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXeydxLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2C61F00A3A;
	Fri,  3 Jul 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083322;
	bh=aSJMDmTocmFWknrZ0msasr+3C7N2TR++7rZ4QOOmN6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXeydxLsqWJOEi94wPXL1PF23YzrW82ubyJICRbsF/QLpK5Oy7c8IdehuFe0+kTpz
	 SdTUp8FN6wrHQ5n9+RXEcJ92FUtIMSaocoJehbvAfwn4+kHgnJAhy5YJw/9UJJ6lf0
	 wwuOFME2MgyIpN2OISua9yPVZo6rC2Q5UpdEFdcQTvI1kvEeZO+EjzDlsBK3WanVk1
	 3rUUQOmt0hYoUUAshrvd1uQaHP6pde00STLOIHqyx204QcsGW8asw4aq26UQ0Rs34i
	 mc4gkUYflrz4m+lSrnZKYUehlTVT5Qz+t1IgqjY46qXvQj+qaAyropDoUaGgbiPNES
	 lrzID/WAF3ZYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/18] mm: factor out can_spin_trylock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260703-alloc-trylock-v5-18-c87b714e19d3@google.com>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-18-c87b714e19d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:55:22 +0000
Message-Id: <20260703125522.AF2C61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe trylock from NMI on UP systems due to missed deduplication =
in `free_unref_page_commit()`
--

commit b53c6ec11ab7f82add433847a77e54a590090942
Author: Brendan Jackman <jackmanb@google.com>

mm: factor out can_spin_trylock()

Deduplicate checks for whether the current context is safe for
spin_trylock().

Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@kern=
el.org/

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c3b246e67ed14..a63733dac659e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

[ ... ]

>  static inline bool alloc_nolock_allowed(void)
>  {

[ ... ]

> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> -		return false;
> -
> -	/* On UP, spin_trylock() always succeeds even when it is locked */
> -	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> +	if (!can_spin_trylock())
>  		return false;

[Severity: High]
This is a pre-existing issue, but could this deduplication also be applied =
to
free_unref_page_commit() in mm/page_alloc.c?

It looks like free_unref_page_commit() still uses an open-coded check:

	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
		     && (in_nmi() || in_hardirq()))) {
		add_page_to_zone_llist(zone, page, order);
		return;
	}

Since the open-coded check in free_unref_page_commit() doesn't check for UP
systems, would an asynchronous page free executed from an NMI context on a
uniprocessor system (e.g., via a BPF memory allocator) incorrectly proceed =
past
this check?

On UP systems, spin_trylock_irqsave() only disables interrupts and
unconditionally returns true, providing no mutual exclusion against the
interrupted context. Could this allow both the NMI and the interrupted proc=
ess
to concurrently modify the zone list structures and corrupt memory?

Applying !can_spin_trylock() here seems like it would fulfill the intent of
this patch and resolve the UP + NMI case.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-alloc-tryl=
ock-v5-0-c87b714e19d3@google.com?part=3D18
