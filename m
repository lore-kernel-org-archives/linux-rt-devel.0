Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064F34C806
	for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841853; cv=none; b=Ba4eLWnDhCxTIRFLadD5zAj+aLD7BCm8Aj9UnFhTIZ6yXPntXKSTN8JL2BM08z5szPDzcmYTTrkmncX/+eOoZYIbfdfo6i6EG3xWDwwFVgvCaztE0AUiTXrnKosgq29bOyc+DDc5B8QMyQmhRvBZ/mLLSyoU40szb0V8eLvyPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841853; c=relaxed/simple;
	bh=UcqyNHXZvx2r6WjOFg4/qjzvwa+voeCemJ2lL0pUUTo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=DEmOKHpino+XYH9Ofv1oHM2v/0seSJRnNiuld0Hjocp1fYFDynL0wgVbV169W/XVFKHxcu0oq5A/TY8KaenM+HkFo3ZOdeknIj/y36HIkXoTFG8vfp0wfhnIx9+VVV1/uAcL7lrF/ixuMA3Bu37OWg26yFKb9o8kTyKAAQSv5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CscqnkS3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CscqnkS3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1822389a91.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841852; x=1790446652; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXlL+5LiPO2Gr9S8btdNT0yhev55DeOp6fa7hhJR9YM=;
        b=CscqnkS3lTWdt7EzZbFXP8gFujScCNlAppvcep4KT1/bndqXP+9RC48EPI3enYf1Mh
         Mb/5N9EVBIPdGNn4f0k883UCij1KlMeI0cRZ1jyULUMtyl6Dk//U7XzHk9xlg2VFyWuS
         IooI2M9LquqT+/EczAy2F0sRr53HgKaFqvwd9bMk8+V/XDQhWBSojRTC8IgBfPJWwYhC
         sphLaM+JX7qA4YnFY7OHaSM8hwwzDLMEeTWi+ng8Ek3q551YvR1+2/VSSC9i60wboFBB
         MMV1y7uipZeGYmElnMa/yGPF49/1R1yoMnncDUmwW7B4EpXpGqSevBps8QK84MAyxeSd
         EO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841852; x=1790446652;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXlL+5LiPO2Gr9S8btdNT0yhev55DeOp6fa7hhJR9YM=;
        b=KS2hfisIoOpuaaXZ/T5ANVxXFisrWzKBokNt+EN4EFrYcE9hl2hCZQ2h1soL1zKFVS
         ciOFWkTMV8EcXZxTv1PnHzddNXNwyyKvuCTkbJ4XcWdslV2g0r5Ye/NTAVGSGh88jbuz
         T65BQ4sQ2sIzGRDz9YBeWPi4vFnU3a1aXKtvA1eT5aP+KP3Lw+NPageecLypmbvwm52V
         Et4rN1mn9w4lifcNrKgMoUArWXTApMmERCnPoXLQMsWuCnaoJJwX2Sv25BgVFijbKMYl
         KwoTfNrL6rGEEQVvxaini6E15wM7NkPnzCN7fofxp9AulpGdu8lkynbvMnz4XQhC5S7n
         7NaA==
X-Forwarded-Encrypted: i=1; AKwUvBwcycq1lW8VDi7qJLKq9jvStf7X6s0865/4qRx9nEcExWrROTudxswLKB6yVYIAJZX+gEG6JD8zE+SECXzPiw==@lists.linux.dev
X-Gm-Message-State: AFuF++nz7Tmy/NDIG27G48OgDRZ6px0T+gBn4ssuA61qLsx1xPPAmXgX
	ADggbIQDYHzbL33qteHBA8c8Yjo5W3OauCD87XY1vOgS5efWNzu3LWInuv2s+Q==
X-Gm-Gg: AYBFou0PYBSigHPnYPVTJCXLxSRx9FzaHQhkQf9ggZOlH5SIXTAdZJ/zv4B6/wRY0Z8
	z3zzrN2E/5uRy+47vlnWA6W8qgwv8/sO1ipMOx+jxJvyVRFuNPhlhuEyNAF8go4Ozd6Fa1Klpti
	M4Z8iirmB7m9xKioL/UKpr427CY+Ge9Tq3zwWYtp0t0K54m5m/26aLNJbF9QwAFHDmYp0tnfQWt
	TPlO78z+otkOgGqVARpdyuMIoMSyYg72L2MKGKcAZ1FBbARyz52lT2kd5SmlB9FGDtW5RDRE5eZ
	wG2c1SetYEkAFLEklosaUIrI7A5KRb8i4OsN1xI/48mWpYM6TX9fDQp+sQXKtjS4JIcY4kvENvj
	rlKfLItgW3eWt7RgxMcDZvg1BJuZemdfOTvKl7LQxthe4fNOys8sdMz1fh6Z7tyijh9XBoqLpwS
	wILeuo+XX9P5JjJCLj7hBGJiVzEDmHJIrNdL08xb0BmUy10Ypw93tuNh4WVmsHOpnIheSM6wzpV
	SR2v9WrDoQCWDR7gmJwNIgD6LfGgeoJB5D9Gqng8NsMGgSNMMh9tpW5tU9mEuqj1CdWwcqdoNto
	cSk=
X-Received: by 2002:a17:90a:d005:b0:39d:f731:e5f3 with SMTP id 98e67ed59e1d1-39e54f0e839mr11355351a91.24.1789841851709;
        Sat, 19 Sep 2026 11:17:31 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm4333791a91.1.2026.09.19.11.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:17:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:17:30 +0000
Message-Id: <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>, "Amery
 Hung" <ameryhung@gmail.com>, "Swaraj Gaikwad"
 <swarajgaikwad1925@gmail.com>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>
In-Reply-To: <20260919171443.90512-1-kmehltretter@gmail.com>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 07:14 PM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> Allow preemptible context only, as v6.19 did. A held raw spinlock
> implies !preemptible(), so the locks of the caller do not have to be
> known. With this change both machines pass 10 of 10 boots.
>
> The nolock allocations then fail on PREEMPT_RT from every context with
> preemption or interrupts disabled, also where no scheduler lock is
> held. Creation of BPF local storage from such a context fails, as it
> did in v6.19.

6.19 had this check in kmalloc_nolock() only. alloc_pages_nolock() and
free_pages_nolock() allowed irqs disabled since they were introduced,
and arena was sleepable only under a mutex back then.

[...]

> diff --git a/mm/internal.h b/mm/internal.h
> index 38b1165212c94..29646c4afb419 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1641,10 +1641,14 @@ static inline bool can_spin_trylock(void)

[...]

> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi()
 || in_hardirq()))
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>  		return false;

No. This kills bpf arena on RT.
Since 7.0 arena_alloc_pages() and arena_vm_fault() take
raw_res_spin_lock_irqsave(&arena->spinlock) and call
alloc_pages_nolock() and kmalloc_nolock() (from range_tree) under it.
With !preemptible() here bpf_arena_alloc_pages() returns NULL for every
prog, sleepable included, and a user space fault in arena gets SIGSEGV.

As Sebastian said in
https://lore.kernel.org/r/20260831143500.x-saxdAs@linutronix.de
raw_spinlock_t is fine in general. pi_lock is special. rq lock too,
I think, since rt_spin_unlock() can end up in try_to_wake_up().
The check has to be about those and not about every irq/preempt
disabled section.

pw-bot: cr
