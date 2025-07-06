Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A11F61C
	for <linux-rt-devel@lists.linux.dev>; Sun,  6 Jul 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751803316; cv=none; b=Uq+/HKyC1ULu7eCnN1N2A7Y1bEqj4ze6e99Kp4cSJRzrPu70ypXPCQixVyzzh/KH1Khk5yeHI0bI4EUBmCLtVv5Uk0XlAOQnX78TkHEbtzDw/ufIUpHghKmfNGfqAekS0EQz+SabaK4H1zAPkLVZwiw2ZrIzZ99wgdl2NzwDyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751803316; c=relaxed/simple;
	bh=9+Rw5JmLc8Nn86iqdSe4m1JHDm1Nblgh6a2vFe0+TAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUr4pq5zh7YWm5Dgwn4+2zw77JzpmJVlIAowN5bqnTtfe/j0r4kupIn7mh0vSl42rLq/wmV4+DL0K+Nlrgi4+8VwqMHjkJJ7Q2i2tFgTQnSihGquV5EIrAS9seEkUw/OEqD+iZkDP78lQJsCcCZjyQJ6v3wzun8umNVjykPEOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS2Qur7y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS2Qur7y"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1716027a91.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 06 Jul 2025 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751803314; x=1752408114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQuFgC4AY34EZXqQntQJRPQXCzjHHMCimbLbW/8CNHk=;
        b=LS2Qur7ytoh0U8FCJFIQHpcMTH+K6VBETnDZoe5EeEIGeHaGyH1Jxc3RZ7HpZbpfIZ
         XTj6Q8l4tmEKohigDpNSa/GGPqN24ge+P+CZwsmphpvw31QT0bp4Ya41Xlg6ijt+4xUp
         2p7utghULz1HiDPvLj+MvFDbxfMEtsGO2NLdYLUVB03nH6SK8768a9sTCZN5f0HFArtE
         SMWvbbvpISwr9DtAqxkgUtciaWLHmx/lPxWZNwkoBUiKtk3gXph+kM74Z8HtOG5bGu/j
         PkUbUwihg18hmq6g3g1mILbKn2PIOrUYAiR9fRu2xabkn6/eXrmXod35lCRo5e7KO4lL
         AfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751803314; x=1752408114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQuFgC4AY34EZXqQntQJRPQXCzjHHMCimbLbW/8CNHk=;
        b=DBlX1IngskSufJrmpy7eVlUzkTnEbuFGfnTLlkOS18+cjwr8LjpFqJZvqYhjuPkqr4
         TrYGkhmN2I7axBZXbcxdzslWllDXq14wGeHYVo+xEzPhnhZ3jhieoFKXnKUjBjwatWa+
         prB3Psct0GS2Vk8NIf207TXPDM2cAnsWxz5jYsUC833A4k4Id11jL3L0+nybTMABrjna
         UWpSogear1xc/B+TNPrHvtK3BhbZsBjpJj6RGbcY/zz8umWvNK8TMsvNQ3VzGht+PSFj
         xvJ1JonKVe5s//GrScTzFNcXkwoN201JLiu3G3pIQPX0d+iXALnYN0zEr3SuALF14CwM
         YurA==
X-Forwarded-Encrypted: i=1; AJvYcCXE0zJTetbdxjafVnNEC2a2wZPIdSyk8KX2xUjeGwJ3CStDuVWCTVwgnALUsKX5OFwwpi/38WSbxfuMUKuUsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4sF9m1RAZo+rjpLSpxAVHJwPSfdvy2lgHRWvUGmbuTJMWHPT+
	b/jOOywmmBJMrh8O+OwlWucvtwX47O7TVLQVkJkgyt10YPia2if+XJ1a
X-Gm-Gg: ASbGnctLTw/oDhijfrvTfsZtgmr4cgloQgY+2Z6ZJsXaJcTj1q5gHM6vYmHlmQmzRWc
	oVVha3x9M1VS5DdsoAXh2rpPDSanTRFU4yZ2RpmSCKzVxSbjejzSQ2ReDsR6j9hTO5TcUpCICn2
	pU53HpWPiCsP0IK3/O8TgZbDDkkyXIh90CmzRaAX6+H8bM/ImZ8pQYTqAMdRpEPfa5H8xmCAWmH
	YUT/Y3p2xl2S9rhgwDd3vtlz1YJ1r0kap9tnHNFqIEOXBXZTaAiJYrIldjr9yHxqIWC6vheKZCi
	+f/DvMnMqGeYaA2l9mxyMkprtVc6oF3uSjBmVEAg3jDttE1Y09wZEtp6Gl5FIMYovB0k/uJ4qVL
	xxmetCDVgYEobidXczN58LMsl+t4GdJIVQ5n64C8W0AUdRwuH0R0E4/yO
X-Google-Smtp-Source: AGHT+IELUtzdFphb747R1FI7mtjA5nZY7T5CTeewMTjBIXzP+KRa3qqBgjMj9UHujZjwDOtoYXrbwQ==
X-Received: by 2002:a17:90b:534b:b0:312:e744:5b76 with SMTP id 98e67ed59e1d1-31aba8e24fcmr9170847a91.33.1751803313690;
        Sun, 06 Jul 2025 05:01:53 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf860bsm9859473a91.32.2025.07.06.05.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 05:01:53 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: rostedt@goodmis.org,
	JindrichSindelar@eaton.com
Cc: bigeasy@linutronix.de,
	kprateek.nayak@amd.com,
	linux-rt-devel@lists.linux.dev,
	ryotkkr98@gmail.com
Subject: Re: softirqs causing high IRQ jitter
Date: Sun,  6 Jul 2025 21:01:48 +0900
Message-Id: <20250706120148.636285-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702130909.0bc4702d@batman.local.home>
References: <20250702130909.0bc4702d@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jindra and Steven!

On Wed, 2 Jul 2025 13:09:09 -0400, Steven Rostedt wrote:
>On Wed, 2 Jul 2025 14:51:37 +0000
>"Šindelář, Jindřich" <JindrichSindelar@eaton.com> wrote:
>> Our team is observing high jitter in certain IRQ handlers on a PREEMPT_RT
>> kernel, and we have pinned the issue to softirqs. However, we're not sure
>> how to address the problem. I'll describe the situation first, sum up how
>> I understand things, and ask questions at the end.
>> 
>> We have an embedded system with the NXP i.MX6 single-core SoC, and our
>> kernel is based on linux-stable-rt v5.15.163-rt78. Our modifications are
>> rather small and don't touch anything softirq-related.
>> 
>> All of our IRQ threads are running at the default priority of 50
>> (SCHED_FIFO). There are also several user-space application SCHED_FIFO
>> threads - some above, some below the priority 50. We also noticed that the
>> application is raising the ksoftirqd priority to 60 (SCHED_FIFO), based on
>> recommendations from an external supplier - the reason being the ability
>> to handle TIMER and HRTIMER softirqs with minimal latency and jitter.
>> 
>> We observe that a UART "Tx complete" IRQ occasionally comes late, causing
>> unacceptable jitter in the communication. There are actually more threads
>> involved (SDMA IRQ, its tasklet, and UART "Tx complete" IRQ), and any of
>> these can come late.
>> 
>> We did some experiments and debugging through GPIOs and found that when
>> the UART "Tx complete" IRQ comes late, it is when there is a bunch of
>> softirqs processed in a row. We set a GPIO when entering the loop in
>> handle_softirqs() and clear the GPIO when leaving it. The pulse we observe
>> on that GPIO when it delays the UART IRQ can have a length of a few
>> hundred microseconds.
>> 
>> Furthermore, we found that in v6.6.12-rt20, an additional thread has been
>> introduced to primarily handle the timer-related softirqs
>> (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co
>> mmit/?id=7f49c1dd9ab0c9f23c526f58241d6cc9d50f1778). We thought this might
>> be helpful in our situation, as we could leave the ksoftirqd thread at
>> prio 1 and set the timer thread prio to 60, as requested by the
>> application. We backported the patch, and it did improve the situation,
>> but it didn't resolve it completely. The IRQs we're interested in still
>> come late, but it's now more seldom. My understanding is that, despite the
>> claim in the commit message, the timer thread is not really dedicated to
>> timer softirqs only. It gets woken up when a timer softirq is raised, but
>> it will also handle any other softirqs that are pending at that moment.
>
>I think you may have found the main issue. That is the timer softirqd
>will pick up other softirqs that are pending. Yes it is a separate
>thread and will wake up to handle softirqs when the timer softirq needs
>to be handled but I don't see anything limiting it from handling other
>softirqs.
>
>This looks like it could be an enhancement to have the timer softirq
>only handle timer softirqs. But unfortunately, I don't have the time to
>implement this. Perhaps somebody else?

I tried to come up with an idea isolating (hr)timer softirq
from the rest. Would be nice to get a comment!

The idea is that we reorder the softirq vector and only handle
(hr)timer softirq and HI_SOFTIRQ in non-ksoftirqd thread context,
namely the timer threads and threaded IRQs' context, and leave
the rest of softirqs to ksoftirqd by checking @ksirqd.

This way I believe the jitter addressed below by Jindra caused
by softirqs being executed in the threaded IRQ context can also
be reduced as well.

----- BEGIN -----
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c0493..d43e59db6efa 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -548,13 +548,18 @@ enum
 {
        HI_SOFTIRQ=0,
        TIMER_SOFTIRQ,
+#ifdef CONFIG_PREEMPT_RT
+       HRTIMER_SOFTIRQ,
+#endif
        NET_TX_SOFTIRQ,
        NET_RX_SOFTIRQ,
        BLOCK_SOFTIRQ,
        IRQ_POLL_SOFTIRQ,
        TASKLET_SOFTIRQ,
        SCHED_SOFTIRQ,
+#ifndef CONFIG_PREEMPT_RT
        HRTIMER_SOFTIRQ,
+#endif
        RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */

        NR_SOFTIRQS
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987c..41df13c07aa2 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -571,6 +571,13 @@ static void handle_softirqs(bool ksirqd)
                h += softirq_bit - 1;

                vec_nr = h - softirq_vec;
+
+               if (IS_ENABLED(CONFIG_PREEMPT_RT) && vec_nr > HRTIMER_SOFTIRQ && !ksirqd) {
+                       /* Restore the pending bitmask for ksoftirqd to handle */
+                       or_softirq_pending(pending << (vec_nr - ffs(pending) + 1));
+                       break;
+               }
+
                prev_count = preempt_count();

                kstat_incr_softirqs_this_cpu(vec_nr);
@@ -596,7 +603,7 @@ static void handle_softirqs(bool ksirqd)
        pending = local_softirq_pending();
        if (pending) {
                if (time_before(jiffies, end) && !need_resched() &&
-                   --max_restart)
+                   --max_restart && !IS_ENABLED(CONFIG_PREEMPT_RT))
                        goto restart;

                wakeup_softirqd();
----- END -----

Sincerely,
Ryo Takakura

>> 
>> Additionally, the pending softirqs can also be executed in the context of
>> any threaded IRQ. So even if there was an isolation where the timer thread
>> handles (hr)timers only, the other softirqs could still cause unacceptable jitter
>> in IRQ handling. In my understanding, the whole thing gets even more
>> complicated by priority inheritance - even if softirq processing gets
>> started in the context of a ksoftirqd thread with priority 1, its priority
>> may get PI-boosted when a higher priority thread runs into a lock held by
>> ksoftirqd.
>> 
>> Please correct me if any of my understandings or observations mentioned
>> above are wrong. Now, I'd like to ask these questions:
>> 
>> 1. In our view, not all of the softirqs have the same priority: e.g.,
>> (hr)timers and tasklets seem important, but things like NET_RX, NET_TX, or
>> BLOCK less so. Would it be a bad idea to try to introduce a more selective
>> approach, where a certain type of softirqs can only be executed with a
>> defined maximum priority? This could make more sense if we introduced some
>> IRQ priority partitioning instead of leaving all IRQ threads at prio 50
>> (we're considering this step as well).
>> 
>> 2. Several of our peripherals use a DMA (our SoC actually has 2 different DMA
>> blocks), and we noticed that the dmaengine is using tasklets to execute
>> the DMA callbacks. This means the callbacks can be executed in the context
>> of an arbitrary thread (and thus arbitrary priority). It feels quite
>> strange to me, especially because the DMA callbacks can further
>> "cooperate" with other IRQs (such as enabling the "Tx complete" IRQ of our
>> UART). I understood that tasklets are deprecated and it's recommended to
>> use BH workqueues instead. Is there a reason why we shouldn't modify the
>> dmaengine (which I see as a very important component in the system) to
>> make it use BH workqueues instead of tasklets?
>> 
>> 3. Do you have any other recommendations on how we should configure and
>> balance our system? Setting different priorities to individual IRQ threads
>> based on how critical we see them looks quite straightforward, but the
>> fact that pending softirqs can be executed in the context of an arbitrary
>> IRQ thread still makes it look nondeterministic.
