Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6117C225
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212199; cv=none; b=VfOV2fH96XcW3dzSDceJ9w9NWrUycRhXmfZVGCSz4Nh/aktYk6NrdIC/Wxqy4cgBuJqQNUAUXONsBueaXXBhiL54JS8STvflSZ+Kqbde9iOCsN3BlTXbee0y93HrB3TEoQRU95bisQmapQrOFnLW4ADPhr3gYWYS7VSelMn87FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212199; c=relaxed/simple;
	bh=b2H0Pm0gr7IK2UiEdH+sjkkYnH/65HprZWAUoEiGIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb1rkitFofX5lAS8NYeO0952fSFr5Pqud00P2HuHZvZIS0T6DibMOSk/29KDG7qpX35Pg+c7oM+pQZcMicQ3yvrNJtE553JOaHzkvLIfrQadYcklS3a5BR8Wcl+WMk6vfg7wVv1gyXpCFFLtUHReBJrFUcHgJUwwfl8iZOXfldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlN2qXhh; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlN2qXhh"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d888c38841so29604306d6.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Dec 2024 23:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733212196; x=1733816996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAc4beHo344rQfywcgFtNMl7CBXH2zQYh6U+MPBRhYI=;
        b=QlN2qXhhPN4SlYYQoGNqpdr+42ezyimJpR8RTQWW37ahqv7leAR3HVyqiYCsLmaqT7
         7uOQbAG+mIJoNtUbl06y0YvdqTB7owGO7o4XfOIM+iCWEwQBrJNO+IgHzrw+daw/vesA
         otmYm489qSkhjc+KPgkcYI852ZeCsC92jUn82UF7hGHN6v6ZexkdrXKLjHnzQoxB6qNb
         drorxB0Qwg8ijizPCFI4YK+QSsZzAZDe2ECEGBUrB1YCPr7O0jcSK+3cs8nUzXGbjN/+
         V7gs1MUhOb1k75zyHFOzZFc35DHRUYW1E+GByQ6OcNV99+DXnDMWGAfjf0xxeplAx8yZ
         T2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212196; x=1733816996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAc4beHo344rQfywcgFtNMl7CBXH2zQYh6U+MPBRhYI=;
        b=VRPMXpxjjezXQ4384nDf4qzFEqIymOe6yM9dGEumgPCCnp1AIWL+FuXTd4if8R6F/5
         MIm8ZJ+j6o5/TCrjAYVSHqaYyHrPU6jYAN8g1eksDeV+iyPaD8WUHUl1AF41rVtNImwz
         ohzCB1Sox++yXSa07DPiabAVWl0Emqm4HETnf8BcWniauEk04ZnSjQ4TqciSrmdrns/7
         W/pxGWBbOzUmFw6gu0kSXO7QHUEcZ1gbEBTe/PvyYQKRiqN6AaN4rRJMWnRd0AwMEOZL
         k+mYW8++1eyF12xvY+48vytXIfsn1mvQltI29vSPG+2ZG27si4qBNSr1EWaQ/T1OO0jK
         WAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUDDg+6T97rjOzvFWsbXXM8WAJPXweMN8k9eotX78OxKVeH8SajRqGTdMCNlbXsMaELGu8wcmpxYVWUk9SJWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy3oVOVbCbVlpWRD0NHtbwXa1uDI5F0/93rfMFJFJio8QRcZMn
	rlLjY3/BfxL0xTGUqfd/cevV/Fij5kRljKMsmmlhU39enPjThfDg
X-Gm-Gg: ASbGncscRMIjpLsm+j8VTtqzGykGlkypf+J8NvG4dDCxNUwoQJ6snFwNFWcEwpatYTk
	kp39KpOxGV798N0HAUIVMR0dKBXhlepNQgNsAQ02jt2bXqHtt3nKSWSjQTvJJYxFyL6pnKfeL7h
	v0Te+4zYd88EpA804QQaP8klGm7V1W53sIEQ3KkRm5RdkV87kmSOKnUlrIcG2005AkcvvRJSKYP
	14wkeW6tVyWTj6DqwywqUDPPmqobVXvn6nPyNsMSQmDcaA7WHZbglNDOY/i4HXEW2/fqUMb3bKq
	SjOC8dRnkPIORfjoOQ66QDAYcDUY3CfHqK1Te5/3
X-Google-Smtp-Source: AGHT+IFfMc5GJOYS4lujSIl+qen6QYERgYOKhcmC/OXIcTO8/V2hPEh2/qveMG2Ne+noziORysSIKw==
X-Received: by 2002:a05:6214:ac5:b0:6d8:a70d:5e48 with SMTP id 6a1803df08f44-6d8b740a271mr35475566d6.30.1733212196512;
        Mon, 02 Dec 2024 23:49:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89848aa37sm34091556d6.100.2024.12.02.23.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:49:55 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EB0211200043;
	Tue,  3 Dec 2024 02:49:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Dec 2024 02:49:54 -0500
X-ME-Sender: <xms:IrhOZz7BPiju2Vya7zo19H0S1vbowPxiLsDARCRhoij72_H7_Gv7EA>
    <xme:IrhOZ44XdLXiwj7opqu1NuxOusp8o39opusynym6BNRaHWPSXk84yDUBrbYaS4AEu
    SFWHw7aXe_WNmoEmg>
X-ME-Received: <xmr:IrhOZ6fz32GIip3vjQ-F2RIXIW029kSOkFgwRvxDdF_SOsIUWNelvd6PsU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieev
    tdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprhihohhtkhhkrhelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlh
    hrkhiflhhlmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehg
    ohhoughmihhsrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gv
X-ME-Proxy: <xmx:IrhOZ0I0GpZfOHp4wJS7oYCdsiPvEckylrNZUWYTl9KsacnICV9ucg>
    <xmx:IrhOZ3JQNxm5BxnCiCVz4OVmtl1ZWwk85NV0govEwewqvhGWazek1Q>
    <xmx:IrhOZ9xI0vRzkvMyyIJpBcesDOpB3n9IQYUWYlljWcgdMyc6Atp6Zg>
    <xmx:IrhOZzI_bJBx3mVtgp6YDvxmMl5uTQfABNvneP9JfLbeUNzqYkIiNA>
    <xmx:IrhOZyahpmUdsOP2BK8Phq-yaJVBDG17yGrMOWcKWvPN8HyDmPp0YCUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 02:49:54 -0500 (EST)
Date: Mon, 2 Dec 2024 23:49:24 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <Z064BAsxrEe5zQV7@boqun-archlinux>
References: <20241202012017.14910-1-ryotkkr98@gmail.com>
 <20241202103228.GM24400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202103228.GM24400@noisy.programming.kicks-ass.net>

On Mon, Dec 02, 2024 at 11:32:28AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2024 at 10:20:17AM +0900, Ryo Takakura wrote:
> > Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> > PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
> > to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
> > as the report accounts softirq context which PREEMPT_RT doesn't
> > have to.
> > 
> > However, wait context check still needs to report mutex usage
> > within softirq, even when its threaded on PREEMPT_RT. The check
> > is failing to report the usage as task_wait_context() checks if
> > its in softirq by referencing @softirq_context, ending up not 
> > assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
> > softirq.
> > 
> > [    0.184549]   | wait context tests |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184549]                                  | rcu  | raw  | spin |mutex |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> > 
> > Account softirq context but only when !PREEMPT_RT so that
> > task_wait_context() returns LD_WAIT_CONFIG as intended.
> > 
> > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> > 
> > 
> > ---
> > 
> > Hi! 
> > 
> > I wasn't able come up with a way to fix the wait context test while 
> > keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
> > on PREEMPT_RT.") without referencing @softirq_context...
> > Hoping to get a feedback on it!
> > 
> > Also I wonder if the test can be skipped as I believe its taken care 

Skipping the test would be awful because tests are supposed to catch
unexpected bugs :/

> > by spinlock wait context test since the PREEMPT_RT's softirq context is 
> > protected by local_lock which is mapped to rt_spinlock.
> 
> Right,.. so I remember talking about this with Boqun, and I think we
> were going to 'fix' the test, but I can't quite remember.
> 
> Perhaps adding the local_lock to SOFTIRQ_ENTER?

So I took a look, SOFTIRQ_ENTER() already calls local_bh_disable(),
which is supposed to acquire a local_lock "softirq_ctrl.lock" (Ryo, I
believe this is the local_lock you mentioned above?) in normal cases.
However, if local_bh_disable() is called with preempt disabled, then no
local_lock will be acquired. For example, if you do:

	preempt_disable();
	local_bh_disable();
	preempt_enable();
	mutex_lock();

no local_lock will be acquired, therefore check_wait_context() will
report nothing. The fun part of "why this caused an issue in the lockdep
selftests?" is these tests are run with preempt_count() == 1 ;-) I guess
this is because we run these in early stage of kernel booting? Will take
a look tomorrow.

Maybe the right way to fix this is adding a conceptual local_lock for
BH disable like below.

Regards,
Boqun

------------------------->8
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d9..d5b898588277 100644
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
+	lock_map_acquire(&bh_lock_map);
 }
 
 extern void _local_bh_enable(void);
@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
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
