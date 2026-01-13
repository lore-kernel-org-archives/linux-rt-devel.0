Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01C36A005
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290289; cv=none; b=fNT4N/ng4ZOrZ7xYK5IsCT+Ahiq4e4s4tj1qASHI3MOWjQu4HGWhRS20fsFeLaldVoecC3bgyE1/Qwf7rxQ2cOFnBaQQ49QbARUL71UJorH+fvl1kMSedWMZl9/40fhbq1Mt4+Tj+g1lE5HJJOdCmeZsEh6VPYoj72AuoZjhYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290289; c=relaxed/simple;
	bh=KHOGbdlV7k26vkBwsFxRWJO0nZolaIWL5Wh/amN5tVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1MAC30x+QiruW+imXT/zy8lbGM8zuwPuChQuj9PF24ED4GWpY1iNSlrzO+3ZSxvRgTTpGQnplK442lJZdvh/zKwl2b3imWvqSLKnJBWNgYOUFPPvMOXEJK7x8VSYTLc97sixbwEYFuVCOdlQBbKU/AgEdyLqCm8Wz05wEuc9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl9e158V; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl9e158V"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fe06a9c4so53471511fa.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 23:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768290285; x=1768895085; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4X9jBZCrvRvaAkjtVEERt7zSzh0BgzYMH50q0yg8K8E=;
        b=Fl9e158V+1xYnzL65ECvCqabmfWG5Twy/s0GVpoE4l9a/jHUULpj6fSCGVMTKKHu6w
         E6/Yh3a8mQslm5v70wq/ej6HQUaEkdhDmdN05GUu6U09mCK2GMqJdV7lcxPTNjDJg0oY
         7zgsJvRG2w+/Stq8Q5wv5jE6X7x3uyjOTsARCf/Xb9CvpLg8sQPMJ4VoFO3SYn631lqg
         iXTbQuX8AziWyjjSVpWbu3VYx7Ff0POA9kLnFr3oxOE5IOuABXWc4Aq5xYgCzX2Ht4ns
         tn5lMMtpLuhIezBjiEzjmB8htwvbWpU+4kZe4TppXMxmFvN7iabNa8Zf+1luTIW2FVM6
         WAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768290285; x=1768895085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X9jBZCrvRvaAkjtVEERt7zSzh0BgzYMH50q0yg8K8E=;
        b=aHdpzN5pw/bJPikfwGFHsr424nl33k1HsREQ8q6YfzDKyNwkdEWM3b8W+I+4ZUmSmu
         I0YuyDE45x3HyAlWNBmCJ6JhSggsWWR2q/lp4Cq7q3YpeZKohCpy0JyIwYxF0rFeaR6R
         0JoFK7IG8Dc68uXEvrgAHuBsH3vYNY/V4R36uEfHhmOGIJf+bDFQEUgaziDKaB/Rarih
         /rxaO6beu2qk1gNY9kWl7JeIt/TC6rc7KvGpjYRbIUymC3Io8noqbPsGyTVHfZk7EABk
         3CEn1tnpqVx8/TPMd1G4ADtMsTpuzGiz/nQd4aXTNeIc3pRYVAIQpoqFgPvmdC26r6u4
         vP3A==
X-Forwarded-Encrypted: i=1; AJvYcCUAPzZC/y3eDvLhZ3Hm3ZPj19c/zHivPYIHtLhBKtowmrwJLqR0t4+9fQPvC5nJXJy9gwco5E8HLsq0vUH7Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq3wYklJlwnTo9hNyJpycYYOMq/zM8N7ITDZjUQwNFLijT++2v
	W+kTNiUpfqSOkD2ku4YdghtShLfaM4XejCX643cH4ZjbFML+AsG0SIL7B2gGQWBiXBUTK/CC+1S
	tAVqSLtLcy1XcjBCIobiuxYlqC2031I0Yx+K9jhXNfSM9YeH+UQrJjtgG73s=
X-Gm-Gg: AY/fxX4CvtL4G86HLlX15jFMpVEiGBAwph1ywgYdEhHeKrlgfsqp8T/sqzHiew4rn0q
	e30/vpj/CIGwpwNuTpbNdNEj4dZqYvu4912i1ou5QR/MhvTX9AVmT6umMhAsJd5ien2qlHl9yf9
	76ZdTzzAxnMbd8udpo0vFLshPmMP2j0L5lIz9PgEgwAExNcOWsOMykvHolgl3wNm4pQQxuzdg04
	MrxzDCaoEpaUrSk3Z2soGF2B7TvE7JCyo8U5yl12+FPJgiVtFdrOEVTs1sWldEvW6k0U4YZKHpA
	ensZJiP6ZpwHhWczfqlxkzlce/2PxupRKxE=
X-Google-Smtp-Source: AGHT+IFtz+zvdIsXlPQGKWHVlaoztqTLpSS53SNPjEbREAG+TNz1QnskQqFZy5PMtrZ/DB2iHyccjztOv8Bx3kXnv7U=
X-Received: by 2002:a05:6512:10c6:b0:595:7cf5:f7cf with SMTP id
 2adb3069b0e04-59b6f0526a4mr6631440e87.38.1768290285197; Mon, 12 Jan 2026
 23:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226110249.0c2f1d8d@gandalf.local.home> <20260112152702.-73BFhnF@linutronix.de>
 <20260112123356.5bc120b6@gandalf.local.home> <CAM5rmdez5fyEU-=MYxpPrg1Sr+VjbMi1tyek17uoJw_4gyMGhg@mail.gmail.com>
In-Reply-To: <CAM5rmdez5fyEU-=MYxpPrg1Sr+VjbMi1tyek17uoJw_4gyMGhg@mail.gmail.com>
From: Jack Lee <liangjlee@google.com>
Date: Tue, 13 Jan 2026 15:44:08 +0800
X-Gm-Features: AZwV_Qjo8lfjfLwvUqJ-p0V5SeNhqvTRs_QbndMGWwPHRKPSEl9ERU2nL_qBKJ0
Message-ID: <CAM5rmdcFmzHCc5j3U8Oid3j5WrAo-44Qvv2V=0BCNAkMwZL-KA@mail.gmail.com>
Subject: Re: Regression in performance when using PREEMPT_RT
To: rostedt@goodmis.org
Cc: bigeasy@linutronix.de, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I resent the email because I didn't switch to plain text mode the
first time, and LKML rejected it. Sorry for the inconvenience.

Hi Steven and Sebastian,

> If you ignore the statement and allow the remote-IPI to kick the softirq
> then the request ends up in ksoftirqd on the remote CPU probably
> accompanied by a warning.

> I'm not sure it triggers a warning. Jack, have you seen that when you
> removed the force_irqthreads() check?

Yes, the below 2 warnings appeared after I removed the checks. [1]

[ 6643.468395] WARNING: CPU: 7 PID: 0 at kernel/softirq.c:317
do_softirq_post_smp_call_flush+0x60/0x70
[ 6643.468594] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G
W  OE      6.12.18-android16-0-maybe-dirty-4k #1
[ 6643.468624] Call trace:
[ 6643.468625] do_softirq_post_smp_call_flush+0x60/0x70
[ 6643.468626] flush_smp_call_function_queue+0x5c/0x78
[ 6643.468629] do_idle+0x210/0x25c
[ 6643.468632] cpu_startup_entry+0x34/0x3c
[ 6643.468634] secondary_start_kernel+0x130/0x150
[ 6643.468637] __secondary_switched+0xc0/0xc4

[ 6644.917108] WARNING: CPU: 0 PID: 340 at kernel/irq/handle.c:162
__handle_irq_event_percpu+0x15c/0x25c
[ 6644.917753] CPU: 0 UID: 0 PID: 340 Comm: irq/301-exynos- Tainted: G
       W  OE      6.12.18-android16-0-maybe-dirty-4k #1
[ 6644.917858] Call trace:
[ 6644.917859] __handle_irq_event_percpu+0x15c/0x25c
[ 6644.917865] handle_irq_event+0x64/0xcc
[ 6644.917871] handle_edge_irq+0x130/0x304
[ 6644.917878] generic_handle_domain_irq+0x58/0x80
[ 6644.917884] dw_handle_msi_irq+0xc8/0xdc
[ 6644.917894] exynos_pcie_rc_irq_handler+0xa4/0x2c8 [pcie_exynos_gs
f050c3a198650ac29c8e84e424e142925038c66a]
[ 6644.917935] irq_forced_thread_fn+0x48/0xac
[ 6644.917942] irq_thread+0x158/0x2b8
[ 6644.917948] kthread+0x11c/0x1b0
[ 6644.917956] ret_from_fork+0x10/0x20

---

[1]: Steps:
$ dmesg -C
$ echo 1 > /d/clear_warn_once
$ taskset c0 /data/local/tmp/fio --name=fio.result --direct=1
--directory=/data/local/tmp/out/ --rw=write --size=128m --numjobs=1
--group_reporting=1 --loops=10 --fsync_on_close=1 --end_fsync=1
$ dmesg > dmesg.txt

Regards,
Jack Lee
