Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418B1F874C
	for <linux-rt-devel@lists.linux.dev>; Sat, 13 Dec 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765609543; cv=pass; b=F8K9xKBPv69KMA1dEBzgktMVFahTskIlVRFHa7rYE3M48K3T0+WLFEheOy2ffO26yVK1ve73K5Hi92xhyE8TE7ZZovLuJXDrVJdHIAvEOVieJh1NI/uewyNifZ++SyQwkyS1eC6adIRHwaiQJ9n2kxgK09Oci4dfc+wm3JbNNBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765609543; c=relaxed/simple;
	bh=oveY6ghAYYW1/assJTaVUMOm3ALmNhblLmKgXg0pPvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NP04iTBHiwl5leHsVRKKeAaBadSkHbUE9/pobfS8csAMhZNBp9WENlJI8rIOPnuMLARHAOQkOTAzvWVKVuaMfnSSmS1l6wUwtrGObOEfPIyHfPrUeapI6M0AhDhOEvTxC7M656nE8p2Lfe8KKwW0IXr8k8NHEzaxm0MsV0gCchc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLDpfBD7; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLDpfBD7"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-597ceef6eebso23731e87.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 23:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765609540; cv=none;
        d=google.com; s=arc-20240605;
        b=JDHIERLZw5rIvtvoAy2sahUL/pqm0yA+qSJvlrqicypvGzK0bDWn78qYLulmrpWpbr
         g4Qvpl9N2tufn9h6aM2nZ6VuTDYQvxj2MzcE34WQ41BFEFIEJAJ2k9Rr+UIbBtDW8uL3
         D8hs+8hQYAyxqRmMEKzSfgCro0UG1nwzAcsOUfM0ev3xd99RMrM7rCzj+PmAos466iQc
         I9LXUyCCRn9KmnlBZVSJbntbqHxvmbPvWM3v4YilwaZJ9i3FIwKpOdv2YXPzAX7u6XZG
         5R48xY9hTw+TM5dGFrEgsPjA3q449PUXVBywR7vBvRFdIY6kO/DtCK4oeTyvKU2v8bpg
         7T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        fh=CcfcP98qantUgFbzyOOt3mXrHcSOgAWXGoc0A8YFt3k=;
        b=Oj39rUvkEMKVClCqQZ4dby4TeUdsKUz73+UGCUEAVncSF9As8qzCxf5QEWpJtgMrHu
         e44Fc35SrTz8sYOQrU3gFTHJ9E+vAq67Wo4ezjK5zNGjSKcWJcSObyBmtMTfOZbMX9LP
         Hmemw1WkVpuX3M57oQNbP36L4lJnGSJrz8SPbtl+0H/iRpRPxcMlzLbYFvAYm8M3qCKB
         FEA6EAUpYhg+/d9uRtkHDz7OIkgjuvMIGmQLfx+KaOD69Zkgujv5uyFe4+yuQFRLEvXy
         zUPu8vwT2IUecfhg/JsSQV2fkGm33KoxLCW/jrLcp/QASH++vgTPOexny/+/6has3oZh
         JkzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765609540; x=1766214340; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        b=TLDpfBD7S8jGV0M0CJTZ+WnEYNiZ77Jz+7P7b1Asb2TgP3HQC4U5ZOdIiesImzC4N3
         Hrs373fU0KOWv0/ilHJsqdE/ezbaCaIsZRtQkDbI/NtKvMcRe1J8phbDuQdLH6l/Omdg
         2o1Kt/ov9POLG1O1v+kjijhj+/KVZCKbMD2JesGVNeOZV+6c7itz7pG3bo3XaQ0w2o/A
         K9yEKoLM7mWST1tGChqMJ0JdXAL2OmgmN0qJwEyvo7caaPCtrJ/uGkYpE75vH7Dcy6Tz
         l0fUv4tEb1aiMJGb8/ySE2xqsTL/IgwDkkzYOOPRq0Ur8D3O3i3RoZgrT0zNltmdZKhR
         6+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765609540; x=1766214340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        b=BYuaK11pha/qzQePUYdYaAdunjrlnp7Mrz+sezNrQU1m13+Iht3Y8cUgDapuCI52U0
         zLxZdnnJbrTmlN/BMFo1PVUs0tafqAITvi2Y8QYfQuTupiM+TucnJpmVayTaGUCjPB0f
         8braMaHTBjvFDlHGmO22fRXcuoOkQciJ8Ow3ZPRnVsiI9ESm/90gdB+rjuRGkoBggeuZ
         gLKtsp5fbPnDMt2eDH9b7+j8gFnAU5/AWpba2L444MprCMMQAijl78oDirNbShvQriTB
         LcikWr2aQTwE9X0KXGmGFSYQWa2cbcQcAzz9zcqoaslctdWKbYye9qvVYGTfLNDqL8xh
         Ywyg==
X-Forwarded-Encrypted: i=1; AJvYcCVRyBR6Yu9kHP/BKoCz3x6G/C52lHBoa+lx27VVYcE4SKIE84kTN/m7IByKRLuUkQ0zReF1cMmn/A4KBGpdrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzixzC3C1r+MBkMstLpZeq5W54SBZOBpTwu2XlmwOmFkV+8qQVK
	4caJk3DMsYwPK+R/t4XT/Q6Z64+tI0Y0YYOSHuAKWv6St60go74b4gZcea/5BaGhlZbJo73Ed8p
	mjDO9z/WaQ+PNS/unzLDsxTiEenqbFyWk+1fYGJNB
X-Gm-Gg: AY/fxX5doy4lBoKKQzi0rVD+RSM8LaCFG5cwbaL08FjufdVRKL1ipVkUKzLkVwU29XW
	nBGeAqPSMlOwImML3aHC6004yBEYomkxhJDkiOqYKUOd99qorC+0NewQuID3eXxX9z+JcFYG5uw
	uThhUuB84YI7ckrO7FKxjFsHcDSqCcF7/rmRxjXueXrp7CFpONzqYqAIizJpZuYAPCp7halkx2B
	f3ywOcRbtIqPjtEZmTnIFdYRF5nPMwrc34YXEs7gDU9c6vJmwt0QzNrLop0KlKQbif7mmiV
X-Google-Smtp-Source: AGHT+IFxhjah2N2uFy306dItOjP0R93hkCDyo1Kn++vNhOwiYTt8khSjxmS7193oFeZUUiU7KewI20Oqx5FGrhIwBmA=
X-Received: by 2002:ac2:5de3:0:b0:594:43e1:ed43 with SMTP id
 2adb3069b0e04-598fe1eb38cmr60101e87.2.1765609539221; Fri, 12 Dec 2025
 23:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
In-Reply-To: <20251212161832.2067134-3-yeoreum.yun@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Sat, 13 Dec 2025 16:05:20 +0900
X-Gm-Features: AQt7F2rPm7R-wCwVHPTjXe_bQj-qNecTeNkHkP5H4J7QvG1ylb2YhWsPANW--u8
Message-ID: <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org, 
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org, 
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Dec 2025 at 01:18, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> are called as callback of stop_machine().
> That means these functions context are preemption disabled.
>
> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> __get_free_pages() couldn't be called in this context
> since spin lock that becomes sleepable on RT,
> potentially causing a sleep during page allocation.
>
> To address this, pagetable_alloc_nolock().
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2ba01dc8ef82..0e98606d8c4c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -475,10 +475,15 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>                                        enum pgtable_type pgtable_type)
>  {
> -       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> -       struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> +       struct ptdesc *ptdesc;
>         phys_addr_t pa;
>
> +       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> +       if (gfpflags_allow_spinning(gfp))
> +               ptdesc  = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> +       else
> +               ptdesc  = pagetable_alloc_nolock(gfp & ~__GFP_ZERO, 0);
> +
>         if (!ptdesc)
>                 return INVALID_PHYS_ADDR;
>
> @@ -869,6 +874,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
>                 unsigned long kstart = (unsigned long)lm_alias(_stext);
>                 unsigned long kend = (unsigned long)lm_alias(__init_begin);
>                 int ret;
> +               gfp_t gfp = IS_ENABLED(CONFIG_PREEMPT_RT) ? __GFP_HIGH : GFP_ATOMIC;
>
>                 /*
>                  * Wait for all secondary CPUs to be put into the waiting area.
> @@ -881,9 +887,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
>                  * PTE. The kernel alias remains static throughout runtime so
>                  * can continue to be safely mapped with large mappings.
>                  */
> -               ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> +               ret = range_split_to_ptes(lstart, kstart, gfp);
>                 if (!ret)
> -                       ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> +                       ret = range_split_to_ptes(kend, lend, gfp);
>                 if (ret)
>                         panic("Failed to split linear map\n");
>                 flush_tlb_kernel_range(lstart, lend);
> @@ -1207,7 +1213,14 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>
>         if (!cpu) {
> -               alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       alloc = (u64) pagetable_alloc_nolock(__GFP_HIGH | __GFP_ZERO, order);
> +               else
> +                       alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +
> +               if (!alloc)
> +                       panic("Failed to alloc kpti_ng_pgd\n");
> +

I don't have the context on what this code is doing so take this with
a grain of salt, but...

The point of the _nolock alloc is to give the allocator an excuse to
fail. Panicking on that failure doesn't seem like a great idea to me?
