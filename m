Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23716FF3B
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647263; cv=none; b=ODuEjKpBl/bluZZJ3e81gPnyLNJNMME92s/6XJhF9Esg5L7QBM6/q6wKCEoOIC8MzXNajF2M6SI5/ORjxeTL+Up4kQ4Y0g+/VtcCCvP6LJfny9PXXJzfUTZpFEpBnWoqazycEMeQVVjmmb5smGdt6Zyq3BW/0geaeJUVquXHA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647263; c=relaxed/simple;
	bh=Nnlu4V1dMgTWeb+SXmzitvv4SFgeg3XO+S2RjAzJJ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCAK2Rh9wePqVuF7csLCwfhp6Wg2Woz6QHxj5AhYoeN18OC7O637suY+xV1bXYZ1Ibi4WAu39zjaTgiQOTh7ckEwVPLH1bXUKs7Mwvqlfqvz0Sfaa8gUH7pj1U35ACniKaJhgFFn3BFHBWkyAR7VxfpiOiNfOwaXUDwC63osN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlUICbzJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlUICbzJ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso10236416d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 14:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734647261; x=1735252061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBKk09YT7x2wE8Yl0M3rh0k89hbVV9jpxX0nYuDcso4=;
        b=WlUICbzJ5n7azP8m3U/rQQTXwjaVFak1LqSaEonnN8UNl3GYpkCEDWOkJsYzdWsosO
         9pOaFlSuKIuEaSE/LbHB2SR5dNT2zDuYqE02f1ixZN5x8PN5/dLflzexEXvcE5EoPIF0
         qP5pBuIJXiF/zohcwVy6Rv74BAyqxuU3cnS3fwJD7SHFeQ5iX+P8fImRpbB0RpI9FSeA
         M+kk1LIVdRYQHgcKgFD2Sb0XnCtKk605BPRxiAr4JyyyJrHCNRSvdwlmaAxFwu8LtUt4
         s42SQljZ2UsyhWSyIjheIMSbDFM5mXtGBe+9JcrDMQ8OpLh19OUSLMlehjmRg3wImuW3
         QuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734647261; x=1735252061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBKk09YT7x2wE8Yl0M3rh0k89hbVV9jpxX0nYuDcso4=;
        b=tYgxTvsGsPMh5gzOII/SNGkM2cJmNnTExYoOhMpnYX3x1Yti8ZSMGp0AqPt5qLduJ5
         VxVUMXWBlaBrRWAv+lFlxgMaFhJzJFgDG/UqwWnvOiQTx967hP3sbbulF0XEWxfBoaO6
         ZjwcXt5GvlEjfzzwsVvg3LYOWtbuw1iN/PTiCBlAOPXC9TGarXSOK1pkFEgUPgFwDuAU
         fmdx6pM6r0/LWOn29S6NxaGYp8epK3OzLGdA6RoYMCcy7HDyB+9dfpcYqKu4olWmZXPe
         dlTrKtrjmQJ5KYQvHXEk0KH2NpFQCEaxQv5tDkPGiCV1z2cRKHLMyouO3a3go55n9BsP
         duPw==
X-Forwarded-Encrypted: i=1; AJvYcCV4WjX8M44w8PScjQPueBJx9B6yWo3Jnj+UtMOFyoSIRKX86mgcvBQ45/0KS5JgeBqaFSyPexBsmBGlAduGYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsKIdxck603k0GMvR4VyGAIYoISEtUQWsmp3+8t7AMojBDsPK8
	cdiuNICmtzFfN8gA2kCmmC40oKazzbGEPrm9gassuaUukGOmLlxk
X-Gm-Gg: ASbGncv3jPtEJk+dh1XrNnW9li4tjgrVba/rztaCBDzZSq7YUMST17duyV94HXLLj3k
	CfnsczIp+FpvnFW7Z2iCtRz93NIGiIw5efvpy45pLjqrp0mfmfVXvj4S968vHDdFZWRt80eRroD
	vo15NCf58eO2doM09QIwe+t9mzfZWq9EM4Deo9KDBKELCsh6VzqJQasFcVdVNkD5vt5HERZl2DT
	WQwosdqs0HQqq5Z0TCHc708yVrSA48v7kLUHM6JfPd2ffrsCWcSzrlUbPUxjGgfMqQT0jyLiVO6
	H7ELJakXSjxUZ5Yt/PvQxG+rs1XZqcpStRrCpOoqOd9ROGs=
X-Google-Smtp-Source: AGHT+IEgx84okc3xV/S0b+ZgzjlyEKBEVJnOkJqrSkyLpcGBTjsV/ec/xTTL88c13loWGDNRUIHp0g==
X-Received: by 2002:a05:6214:1306:b0:6d8:ac5d:b83e with SMTP id 6a1803df08f44-6dd233a8284mr10804586d6.47.1734647260917;
        Thu, 19 Dec 2024 14:27:40 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c0fc5sm10672416d6.92.2024.12.19.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 14:27:40 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id D540A1200069;
	Thu, 19 Dec 2024 17:27:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 19 Dec 2024 17:27:39 -0500
X-ME-Sender: <xms:251kZ5TrICLspGJuu5bNfRBsDtNVoK0a1CEhgD2PesHUso6i9tpIPg>
    <xme:251kZyxiEejfySHBPN0KH-3sdo2GdNMlVoqSSxODVbf7o0EepcHY7SLAZp6rqY-Mm
    Y4A0-ZowvpoZgB8IQ>
X-ME-Received: <xmr:251kZ-2sig2nElyCrycd_B3G0vf3l7eAp5OGEvQubRl-Y1z8pv9sU6V0eQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceo
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehud
    fgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
    dpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehr
    hihothhkkhhrleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgoh
    houghmihhsrdhorhhg
X-ME-Proxy: <xmx:251kZxD7x5DmTIbCbXDNnyTQ3TI4Q61WwJ3J0jR5LEyi5xUtpBfrjQ>
    <xmx:251kZygKut9K48yXh6IHo8yrseepXhPpCyNyDCGx5nq2kzZ894ie3Q>
    <xmx:251kZ1rfHPXL3eCmucLX-bZZ2nZPH0tRvWW91VtYgmOxCcUOyawQhA>
    <xmx:251kZ9iGi7Pf_UNu98R5uu8Mi9FpsNRvsvxdG88YSMktRGgEtpgVTg>
    <xmx:251kZ9RGX3UjMa2F8FLH2t6vG1VtPaazxaw1QhBOy_AZ3j1AM2KcxDKk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 17:27:39 -0500 (EST)
Date: Thu, 19 Dec 2024 14:27:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: peterz@infradead.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, rostedt@goodmis.org,
	tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <Z2Sdv6tSEoxiYW4e@boqun-archlinux>
References: <Z064BAsxrEe5zQV7@boqun-archlinux>
 <20241209160943.254299-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209160943.254299-1-ryotkkr98@gmail.com>

On Tue, Dec 10, 2024 at 01:09:43AM +0900, Ryo Takakura wrote:
> Hi!
> 
> Sorry for being late on reply. I was trying to understand some 
> of the selftest reports that came across...
> 
> On Mon, 2 Dec 2024 23:49:24 -0800, Boqun Feng wrote:
> >Maybe the right way to fix this is adding a conceptual local_lock for
> >BH disable like below.
> >
> >Regards,
> >Boqun
> >
> >------------------------->8
> >diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> >index fc53e0ad56d9..d5b898588277 100644
> >--- a/include/linux/bottom_half.h
> >+++ b/include/linux/bottom_half.h
> >@@ -4,6 +4,7 @@
> > 
> > #include <linux/instruction_pointer.h>
> > #include <linux/preempt.h>
> >+#include <linux/lockdep.h>
> > 
> > #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
> > extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> >@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
> > }
> > #endif
> > 
> >+extern struct lockdep_map bh_lock_map;
> >+
> > static inline void local_bh_disable(void)
> > {
> > 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> >+	lock_map_acquire(&bh_lock_map);
> > }
> > 
> > extern void _local_bh_enable(void);
> >@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> > 
> > static inline void local_bh_enable_ip(unsigned long ip)
> > {
> >+	lock_map_release(&bh_lock_map);
> > 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> > }
> 
> Maybe &bh_lock_map should be acquired at local_bh_enable()?
> 

Right, local_bh_enable_ip() seems to be an unused function...

>  static inline void local_bh_enable(void)
>  {
> +       lock_map_release(&bh_lock_map);
>         __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
> 
> On !CONFIG_PREEMPT_RT, I noticed that softirq related selftests
> (e.g. lock-inversion) fails with recursive locking error
> 
> [    0.741422] ============================================
> [    0.741447] WARNING: possible recursive locking detected
> [    0.741471] 6.12.0-rc1-v8+ #25 Not tainted
> [    0.741495] --------------------------------------------
> [    0.741519] swapper/0/0 is trying to acquire lock:
> [    0.741544] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
> [    0.741621]
>                but task is already holding lock:
> [    0.741648] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
> [    0.741721]
>                other info that might help us debug this:
> [    0.741750]  Possible unsafe locking scenario:
> 
> [    0.741776]        CPU0
> [    0.741793]        ----
> [    0.741810]   lock(local_bh);
> [    0.741840]   lock(local_bh);
> [    0.741868]
>                 *** DEADLOCK ***
> 
> where it does SOFTIRQ_ENTER()/EXIT() and SOFTIRQ_DISABLE()/ENABLE() 
> as each enables BH with local_bh_enable().
> 
> But I was little confused that isn't recursively disabling BH allowed, 
> especially if PREEMPT_RT doesn't disable preemption? (I was also 
> wondering if disabling BH recursively is something that can happen 
> on !PREEMPT_RT if it disables preemption...)
> If so, wouldn't report for such case be false?
> 

I think you're right. Recursively BH disabling should be allowed, what
I missed was that we should use lock_map_acquire_read() instead of
lock_map_acquire() in local_bh_disable(). Because as you said,
recursively BH disabling should be allowed therefore the virtual "lock"
of BH disabling should be a read lock.

The following is the rough idea:

Regards,
Boqun

----->8
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d9..7191a753e983 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,7 @@
 
 #include <linux/instruction_pointer.h>
 #include <linux/preempt.h>
+#include <linux/lockdep.h>
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 }
 #endif
 
+extern struct lockdep_map bh_lock_map;
+
 static inline void local_bh_disable(void)
 {
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
+	lock_map_acquire_read(&bh_lock_map);
 }
 
 extern void _local_bh_enable(void);
@@ -25,11 +29,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
 
 static inline void local_bh_enable(void)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8b41bd13cc3d..17d9bf6e0caf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
