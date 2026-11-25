Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599571;
	b=Z1VUTDT0lTPPJvpxchWIhuo+5BjGP8CkN/zMCvkw1eBXw87KwHvTbDAznrB0ONufwmF8
	 HD56W262lxtSp6a86Eex1qWqcE+2UbCH3BjFccJ7V5XcPG6Ey+gWH4/oIex0jKp3JfYKR
	 nuFtNJfDs/F6q9eTJvs462tPctlGIukLH6LeiZnmRv6y9OV4skqd2rRcBbRpXimVl12nn
	 7cJ94JPeE9JDmUA1QWnkNfykEvG7/LHqzAXyhNrvo29IrpmQoHW8BIYN67CvxlkF3564K
	 h3Nukd/tFQKj9JGRy4Ku/rFnckWgKfTX/zYvBOwIyxploFZ8zACU3Q/EUTh/mjvMUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bp3LdbYywjDt4RIw1F5hpk6VusK+9ru0rpOgIQ7EDh0=;
	b=Ode+3RuDCgvftdB+zGlPtvvsNgin3X2Y0m9DZN/uyN++M/Dl05+SQ7Ynfnpd67bEagHS
	 B3ZrUpGHtxfm4m3TUvSog6gPCeOYxl5MG+mPa2ZlfuIuer4jPyiyPSz64r3kZlX0GUNoA
	 gzbTgamWo8JgKNw+0CSHbMUfJYjgb7S32+2QaRy3Xb4AbFjIcoxFV7d+u5ARYflmwSo2v
	 K0/y1w2gtZ7mTTilICyEY2ozeQKvvUb6+VoZz5VQn2pUrRpnJaEksAnYMIv1YwqM7O8gE
	 dKE7NrvZ/AQqGM4RD+FM+MQAXmZyVrOFseuon6QLDE7+4wmrgO/iS6gL8lCD2hNwKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TE8Aznko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF02606A329;
	Wed, 25 Nov 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TE8Aznko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80C1F000C6;
	Wed, 25 Nov 2026 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599570;
	bh=bp3LdbYywjDt4RIw1F5hpk6VusK+9ru0rpOgIQ7EDh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TE8Aznkofnon7JjG8UuHYeQ5xQmQK4AzGQPEZ6r5gSMaB0h0OG0Wu5so8iK4yi3SL
	 OUzJBnLC6pNJKO3qo9YgJRcdxrsoZ+CBU7IqrzS50Y+rNn8+HrjfW4D5m7OC1qwCnP
	 iu6J6r4OCidFxwoANq0k18X5qTgJJJJ7JJ2zq7F1ArYra+MSvUYy5NxDmB/75tmuR+
	 nQ1hGsbGdSSKfprz1Yme25HuaWfmAiQ2l3j/LjoqqNdK43zDDbDK6OMvp9p79vjHgJ
	 AKfzgOWq9T3drbFomAVBwf1hd7M+5aJjj2sM82bhhB8b9P0wNFjEDTECjdLqDTtSUO
	 nDoYdkNMRwGaQ==
Message-ID: <sashiko-outbox-233019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Jann Horn" <jannh@google.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Ying Huang" <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, "Kirk Swidowski" <swidowski@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
References: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:39:29 +0000
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
- [Medium] mm/rmap: uninitialized tlb_flush_batch counters in mm_init()
  on fork()
--

commit 087cd5390dc5a69ffce740207a46d0df64ca3039
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/rmap: avoid reusing batched TLB flush generations

This commit replaces the packed mm->tlb_flush_batched counter with separate
32-bit mm->tlb_flush_batch_pending and mm->tlb_flush_batch_flushed counters
to prevent generation reuse races during batched TLB flushes.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ed35d258d2e3..9f51a0ec67451 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1407,7 +1407,8 @@ struct mm_struct {
>  		atomic_t tlb_flush_pending;
>  #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  		/* See flush_tlb_batched_pending() */
> -		atomic_t tlb_flush_batched;
> +		atomic_t tlb_flush_batch_pending;
> +		atomic_t tlb_flush_batch_flushed;
>  #endif
>  		struct uprobes_state uprobes_state;
>  #ifdef CONFIG_PREEMPT_RT

[Severity: Medium]
Should init_tlb_flush_pending() also zero tlb_flush_batch_pending and
tlb_flush_batch_flushed when initializing a new mm?

During fork(), dup_mm() copies oldmm with memcpy() and then calls
mm_init() -> init_tlb_flush_pending(), which only resets
mm->tlb_flush_pending.  Because tlb_flush_batch_pending sits before
tlb_flush_batch_flushed in struct mm_struct, memcpy() copies pending before
flushed, the opposite of the flushed-before-pending order required by
flush_tlb_batched_pending():

CPU0 (fork)               CPU1 (reclaim on oldmm)   CPU2 (flusher on oldmm)
dup_mm()
  memcpy(mm, oldmm, ...)
    reads pending =3D P
                          try_to_unmap_one()
                            set_tlb_ubc_flush_pending()
                              pending =3D P + 1
                                                    flush_tlb_batched_pendi=
ng()
                                                      flush_tlb_mm(oldmm)
                                                      flushed =3D P + 1
    reads flushed =3D P + 1

The child mm starts with tlb_flush_batch_pending =3D=3D P and
tlb_flush_batch_flushed =3D=3D P + 1.  On the first batched unmap in the ch=
ild,
set_tlb_ubc_flush_pending() increments pending to P + 1 (where
pending - flushed =3D=3D 0), leaving pending =3D=3D flushed while a batched=
 flush
is still pending.  A racing flush_tlb_batched_pending() in the child then
sees pending =3D=3D flushed and skips flush_tlb_mm(), leaving stale writable
TLB entries behind.

Even without a concurrent update during memcpy(), inheriting unequal
counters from oldmm causes an unnecessary flush_tlb_mm() in the child and a
data race on oldmm during memcpy().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-rmap-v1-1-=
e3dc48a4b527@kernel.org?part=3D1
