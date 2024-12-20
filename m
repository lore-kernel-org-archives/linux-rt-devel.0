Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598F21D5A8
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721231; cv=none; b=I7uFfd2Nj/a0aJY3HS927j+28fjXKWxMzsi1Xqb8g73wJvyoxG+05ufkfF1GkBaogTp5aBjMhzhvCo0AFIiZuQoO4rwNsJoEgNpE8CfFeCBC3/qxgLZYU+ahfu7ic30tpV2OaPQNxnWamYX2xkSpuoINhrpOCNWpiUfZEOB/KxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721231; c=relaxed/simple;
	bh=DcI407VL3jzMpdIUpTsQAQ7Fwrv0oYJ68zmeYct2Wl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOlHH48x5wgT849MDW3Rjpv9aFnC2lzlC5W+3yeZnm4TbeXZ6dTUGC18zvvqpZKx8pNdM7cdb5NtE5gn8Tu84Dl6xaIgCBozbbfdAmegagZPalYMKQiafbdHo9jvF3tIF+XvJ3jaeEIGRPGjPZK8qI58vlMeiBv3VN3//QlF9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOnigwFa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOnigwFa"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46677ef6910so22394841cf.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734721216; x=1735326016; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIKsmEYBJU5cUCCOWLWX32/3tfdNXhpSh22eOWASL7s=;
        b=SOnigwFanuxZ+o8NLmZKZwvztyY/5JD+78o33G+x0Kh4InCqfinniHkXHCGUe6IkNE
         n2vesUdSqtU+F36tfo/kdysKVOyEjPblsMHCTBzIWv+f9vKkEgOuLkA5D2JLa+z/qAib
         TdPfCBCblvYIuMyldkLIXOUmVRRyz1dRcBG0kgvgJtd+Ogr7YsnVx5+i8HXqLQFEdllX
         r5B7Vo1ObPtkWeeMPYvEeF9oR9iiubgd5vLBGx5XIHXloZIstwuzdJFk8OUHPgqXaCr3
         EpsxP5Q0lMYfTy1mhfrFWXELnyKgURvIefxiDgasgI3afYbA8/NebUicI+ilvFRNsc6F
         UiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734721216; x=1735326016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIKsmEYBJU5cUCCOWLWX32/3tfdNXhpSh22eOWASL7s=;
        b=OOgFLzfXEsy+FddYcDP/UXoDjQ46u1kMWqGxen5ZEYYpKpQJWAgrgo2orS/2jB1fdR
         +ybxBpcN4/9ASSMbflGrAyfC+0gYd4H/Rat3tvvpUi2QLDynlykoNdsbXmCZc+exnv0f
         +dCsPNQfPim04dZD8iOQGfNkg38uzxPyQdNC06aiBtiOvIX3thdxexbiQ5yOZfzG9lOZ
         4IaItIeMl6r+jEyM0bo13MpTtRMEdByrM5wZV0yaaaAoA9dp+pr6v/5hM/0QSyesY1rB
         VUAoAtmF+dLw2Gc3QQ6IuEkFop7CuEandqUsv+v2r4W5jgx9H/+9tfXBjJsEDgCatkBV
         Rq7g==
X-Forwarded-Encrypted: i=1; AJvYcCXL+SqvmbS/1cUpXug2Xqz1/y3h4n0PZqx4pHeKLAQ0Mu3IgAwBRlVINLxgPl2/OysWJPx+fGQrnb4bpgztHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4yvuguHxqGMLscNJEno3a1epcig1l/3VMcVmrmBGIozti1g8v
	5S4sAgQl8AcOHVdKqvDSfJZ5V8+ESE7AkX0BA/i4ymsf6yV53PTt1KPE6A==
X-Gm-Gg: ASbGncsGE4WnSWEez0omhVUQWbewJEfwJqUGs3oh+FXa0cp2eoW+ui8kToIjJXcgqJB
	nSPSqydTPYMzsKDPVy7m9+C/DMfJKHpIQXU4XnHJV1NTf2O0EMtYbraD08CLC/ZwvZKBzkfo+Fu
	PQaISXXA1C6uOxPTU23CU9MeCkuh7beXEXIV3u4Nrx4znQLqwpf8XpLWun94NpHCFyiCRdfP9vy
	5JoVMSOWB6JlPKn52xhH/IYWpzi0d/GTXb4jpQk7yEBFdgJ8PtWbbn/CYJR0l9eMmjxC33r5hYg
	lRQ0Cpv2+NDL0YRjgWZj1QV0VukE2KrAT7DQjSAPgSWD/UM=
X-Google-Smtp-Source: AGHT+IEvWHz9wFWRe0xpJhj8GL8Jpmis1TM+GIs5mhBnfsxebBmE8kIRjGSFBPRKg8djD+mgqP/Mjw==
X-Received: by 2002:ac8:5a91:0:b0:467:6283:3c92 with SMTP id d75a77b69052e-46a4a8e21fdmr58136851cf.12.1734721216057;
        Fri, 20 Dec 2024 11:00:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cf0fsm19354691cf.18.2024.12.20.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:00:15 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 019101200073;
	Fri, 20 Dec 2024 14:00:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 14:00:15 -0500
X-ME-Sender: <xms:vr5lZ77bBDmth2zlqgIA6IA-wFR5BwgOnsWuNCDDaRysEk8DDZerwQ>
    <xme:vr5lZw5gnEP0wq9XyZ36pg64FL6vpsU8X4DZPDNHOQVzfXcvxaA8BwXNa8r65t8fm
    8jlq6J2IEJZYnr4OQ>
X-ME-Received: <xmr:vr5lZyfSKfBDZn0NBZreFQFmWzEXQ6cfCR3UWkCJUHoRlL96qo2hDKMFB-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceo
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehud
    fgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
    dpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehr
    hihothhkkhhrleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgoh
    houghmihhsrdhorhhg
X-ME-Proxy: <xmx:vr5lZ8LwdKcp255j6Hc1wu6yvx0HogzxGwz-fLXtLzGHluPMwxM5Jg>
    <xmx:vr5lZ_KSNMiOy04Z5FArjWIc1x2YOPNr7xiddr1-HMR3dXk9K5jG9w>
    <xmx:vr5lZ1yZZk7KqXBtyasva6eF7aH3i0pIT5QnHH8yZE72twkE1zWVwQ>
    <xmx:vr5lZ7KF5SrfFvtkVS1M9FdKcg4glNysFKjmRS6WI1nJhsVl7YAhvQ>
    <xmx:vr5lZ6aloB7lrhoucq75-x8B36NNVoOc60H8cvuAhI_Lz_6gd9WQIoZf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:00:14 -0500 (EST)
Date: Fri, 20 Dec 2024 11:00:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <Z2W-veam4RP1C6zM@boqun-archlinux>
References: <Z2Sdv6tSEoxiYW4e@boqun-archlinux>
 <20241220161016.422991-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220161016.422991-1-ryotkkr98@gmail.com>

On Sat, Dec 21, 2024 at 01:10:16AM +0900, Ryo Takakura wrote:
> On Thu, 19 Dec 2024 14:27:11 -0800, Boqun Feng wrote:
> >The following is the rough idea:
> >
> >Regards,
> >Boqun
> >
> >----->8
> >diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> >index fc53e0ad56d9..7191a753e983 100644
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
> >+	lock_map_acquire_read(&bh_lock_map);
> > }
> > 
> > extern void _local_bh_enable(void);
> >@@ -25,11 +29,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> > 
> > static inline void local_bh_enable_ip(unsigned long ip)
> > {
> >+	lock_map_release(&bh_lock_map);
> > 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> > }
> > 
> > static inline void local_bh_enable(void)
> > {
> >+	lock_map_release(&bh_lock_map);
> > 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> > }
> > 
> >diff --git a/kernel/softirq.c b/kernel/softirq.c
> >index 8b41bd13cc3d..17d9bf6e0caf 100644
> >--- a/kernel/softirq.c
> >+++ b/kernel/softirq.c
> >@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
> > {
> > 	return from;
> > }
> >+
> >+static struct lock_class_key bh_lock_key;
> >+struct lockdep_map bh_lock_map = {
> >+	.name = "local_bh",
> >+	.key = &bh_lock_key,
> >+	.wait_type_outer = LD_WAIT_FREE,
> >+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
> >+	.lock_type = LD_LOCK_PERCPU,
> >+};
> >+EXPORT_SYMBOL_GPL(bh_lock_map);
> 
> Self-tests are now all passing. Thanks!
> It looks good to me.

Good! Do you want to continue working on this based on the above
changes? If so, feel free.

Regards,
Boqun

> 
> Sincerely,
> Ryo Takakura
