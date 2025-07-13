Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0A4A00
	for <linux-rt-devel@lists.linux.dev>; Sun, 13 Jul 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752370808; cv=none; b=egb1yS34DqXvjCUajKmP3WevVWKv7MC+KEE3R/LDU/FTor83qzSGBWP3OY+1+ZdlwkDCouHnj6OK34HdVBMJ1i8g9jns38Jw2Wy8HNXvO16Xjsal1Uo0cuFFOO8OhUEiOg0NfOU/6jtTVm9JncZVKV0NZOA7mo4lcczaH5B1RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752370808; c=relaxed/simple;
	bh=/AwR0ua/ED6LRRNkdUOFVPpiq1GEP1qDIYsBczx8pZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvI8UttqeryyKMzifxU/Cjc9pkq8dZuNhHgo4pseY063gkfIWGLv3LsoGLTzLBEz5GAlmIzTAinoF60k7Na1uMSPlHwSFf4e4k2uqqu3GRNBDZQOvCWusiqn+nqeE0VvBzx5FKgfc3oTsbGRhg8y/kstuxCfHFBaGdD/2l7c+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHKSmf+h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHKSmf+h"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8a5053c2so31525425ad.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Jul 2025 18:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752370807; x=1752975607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmrloEta2YZzoHnWuItiK6tYnNXcASCT61BfBLdbbg4=;
        b=CHKSmf+hupNwvyEwm0+hYxEndq5/3JFasDQotta2ELYIruRobUQXPp4YHRsNJlNlhN
         tfJB5DqeL4GzBweu+VRa5iF/hIxqNqK+hAT6j1LHXwqJDXgtxkO+VSldTfI9GAT6txga
         70PXFDieo5yRHFhY8i+PZrdO4a8aJQb43mcGaM7xdQUptQfot0BTUD9bxUA8DLaq5avl
         JJBiuHkgXLs/PLFzcEqcENNdkTZ272+P/0dEJmLXY7eqeDFZVFzGjlri1rlUZmMuBZ0I
         twjXoCOeTAZpQ4hCFObTN8N17A3bbQ1SqGptfIV9iOf0VIj9e+iC9em50rTYQflwWIpY
         TZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752370807; x=1752975607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmrloEta2YZzoHnWuItiK6tYnNXcASCT61BfBLdbbg4=;
        b=PSxvkqpZMDl1Xlvy2p5f3K6fnzt1gjLaU6pmUJ0upR+tDbcxNa4+9Ck2cxk1Og3xk7
         bHIse3ys4ciMbeBnM5+16ojrpsEvj9BI9yWIzYDDtos/PS/quL35QHXIFqq2pKc1Yelc
         /k9Kfc1kmfLksqOrYXKi2qDOQ5IXXOSKIMkXWRX/3eRpS/j1z2ehLo0Ii+O9aBXadgDz
         VPbAsoQ2Vl19VeetG/U9jw/lOT9tpwrgRTDePmCobr2O32TJBHZmhKfvRRN3qbVKg0bJ
         Nc35wxc0NcgWwmO8v4MLJqpqD6F8aIPYzye9s6Lv8jFWUVr83U/VoBZpvFo3BgFg7WSi
         Q+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfjCqzD4bK53hswo0Dt4OvXEhvEI37/3g/6Hau5cVMfbitAfP2dwN8/DVzheTMH8ULhySAZEGgWRol8iYqLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzes1zcGPFkHIwZIcp49QsbTkgESNanE/7pbkfUrJBg3gVUuEFu
	XdIHAovYAR5ShydkO4zDOYDN74E+4iVm8tgwwIin5vseKJ+R/tE/DHzE
X-Gm-Gg: ASbGncujM4rCnedbxWWTgIOds7FlYuXTDSCijHwMl9DO6HznQ2qZGJI2Cy2nhdBZJE/
	Q3jMHErjg6LpU/uUb0TPCXJXrQuuIo/YRmnakuaP5u/VqdjJC/YqN/eaqyCe5zHN/1wUkQCeZP/
	Ups2+o/z0Dx2MOWSg/yQ+FNi4l+Wvr6w8DBGff1eTMYM590WKtjGvojCQlXC8dB43m8PDkmfCCK
	SQlU3LnK1noN1fCc3ONA2wudi5bjlPvI7mYPf9QLHno96vFTyIsUfMNpnQmNw0eavEsZu+dbEiH
	/D4iPvnvmD6nwTeGgvUuHW+V42L2Z0H5i6N9a5aetaye9dYdZ4BvUGJ4/dgV3HkNS+6U82LNQMQ
	GtMtDcA0NILlNn84sCnvcyOvz0sLpx8oG9xNEzV5N9pQRe8nTEF8hp9j+Dz0cpj1URgj7BKly7o
	2Y6SvES2CPnGrUFLd3
X-Google-Smtp-Source: AGHT+IHvGOae2sbHhP7YV5X+dN+9x/FRTMUpxvIZfDK9QtC9XhItyGQsAXWfvD1S9YmtqAatDUov6w==
X-Received: by 2002:a17:903:98c:b0:224:76f:9e4a with SMTP id d9443c01a7336-23df080e23dmr109691755ad.14.1752370806740;
        Sat, 12 Jul 2025 18:40:06 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332d3asm74310765ad.152.2025.07.12.18.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 18:40:06 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: jindrichsindelar@eaton.com
Cc: bigeasy@linutronix.de,
	kprateek.nayak@amd.com,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com
Subject: Re: softirqs causing high IRQ jitter
Date: Sun, 13 Jul 2025 10:40:02 +0900
Message-Id: <20250713014002.221908-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SJ0PR17MB5559A9917E0B59AA6203C633D74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
References: <SJ0PR17MB5559A9917E0B59AA6203C633D74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 8 Jul 2025 14:36:23 +0000, Šindelář, Jindřich wrote:
>an update from my side on this:
>> Thank you for confirming this. I am now leaning more towards trying
>> even more separation, to achieve a state where, if handle_softirqs()
>> gets called in a context of an IRQ thread, it will only handle the
>> softirq raised by that thread, leaving the rest of pending softirqs
>> untouched.
>
>My way of thinking about this separation (either only for the timers or
>for per-IRQ-thread) was based on the idea that inside handle_softirqs(),
>I'll only clear some bits of the per-CPU pending softirq bitmask and
>leave the rest pending, i.e. modify the code mentioned above to
>something like this:
>
>    // ...
>    __u32 softirq_mask = 0xFFFFFFFF;
>
>    if (in_timer_thread) {
>        /* when running in the timer thread, only handle the (hr)timer softirqs */
>        softirq_mask = (1UL << TIMER_SOFTIRQ) | (1UL << HRTIMER_SOFTIRQ);
>    }
>
>    pending = local_softirq_pending();
>
>    softirq_handle_begin();
>    in_hardirq = lockdep_softirq_start();
>    account_softirq_enter(current);
>
>restart:
>    /* Reset the softirqs we want to handle in this run, keep the rest pending */
>    set_softirq_pending(pending & ~softirq_mask);
>    pending &= softirq_mask;
>
>    local_irq_enable();
>    // ...
>
>The issue here is once the IRQs get enabled, the rest of the code using
>local_softirq_pending() to check what's pending can immediatelly start
>handling softirqs again and again...

Maybe I'm missing something here, but my understanding is that pending bits
are expected to be set once IRQs get enabled.

I do think we need to try avoid restarting for those non-timer softirqs
that won't be handled in in_timer_thread, something like below?

        pending = local_softirq_pending();
        if (pending) {
+               /* Don't restart for non-timer softirqs if in_timer_softirq */
                if (time_before(jiffies, end) && !need_resched() &&
-                   --max_restart)
+                   --max_restart && (pending & softirq_mask))
                        goto restart;

                wakeup_softirqd();

Sincerely,
Ryo Takakura

>I thought I could do these changes in a local and relatively non-invasive
>way, but now I see the use of local_softirq_pending() is spread over
>multiple places, also outside of softirq.c (namely in smp.c and
>tick-sched.c). It appears to me that the approach of "let's only handle
>some softirqs and leave the rest pending for now" may be very difficult
>to achieve when the single pending softirq bitmask is checked at number
>of different places and it's assumed that whenever it's non-zero, it
>should be handled on the first next occasion.
>
>If anyone would suggest a different way, I'll be happy to hear it, but
>I don't see any reasonable approach myself. I think I'll focus on
>different ways how to reduce the number of softirqs occurring, maybe
>trying to use something like BH workqueues for some of them (NET_RX and
>NET_TX come to mind).
