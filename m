Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2519D07B
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Mar 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927413; cv=none; b=JUCTn9cVrzJa5QuwB6mY5uDiV95Yovw0yGA2T/R52bSR6rLgghKRHle+c0mRBvyT+nc4eQfJrsrFUC5340YAxEH/XY4OyhC7bRds/Ex60RkAK8JBwnch3P9DI4OwJO+1hE9ou2O7BAQaYQmSDqyrQ6RmPJsSSKLmoxxX0jAqr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927413; c=relaxed/simple;
	bh=Z/9lJhVTBRGnad0GoyXoA1eCrn4cxADU5RuFqiIZpj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5qPWJK8L5lz8eNOlfZRD/CcngyzTPScBQkdMX6kga78hI+huUcuyugAmA/+KtOzCu7QeNdLUvhuIeek5lL6CPiqYZpTkjGqgWafJBUUdi8nA8yInQLekbZ06sFij/uJVnsC0/PG5T0KcQ2lXZ/7mfakqy/dg5bZ2a4sCwye/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkANgz1m; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkANgz1m"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e1b40f68so66131485a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 25 Mar 2025 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927408; x=1743532208; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8eKmhB4IFnu/wWz9bz23aTCFYM2BiZ97FbsYtffbs0=;
        b=AkANgz1mWccd051wQKq2S0EWm37T6eHmz6QyUSxD3gfLEFA/PKriqBNp8Y/uRK+KKq
         pM1b6LdT5w1f7fjV0Rc+ell/HmqUf1i/bpg3yrZkBJsIQhJgtwUzERcalYMnUpEzeSqj
         s38ccR2nAS7HztMZ19LYfVWHuw/tZSidZbcw2WtvQXKH1yOLIdvHXOVudy2Z2gQROE6J
         2KjuibP+slvaZ+MQ1/oSlJbNEhX65Go8GJPuH3tpGA8eLzeZxaKKl+1SEYnxJXKb8gAg
         ap9hAl5jalcLS4BCMRzln7UxXKsy5Zirw1yT43En35e/T7GVeCUxnmF6Ypq6VyomVRyV
         N/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927408; x=1743532208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8eKmhB4IFnu/wWz9bz23aTCFYM2BiZ97FbsYtffbs0=;
        b=KVJWoSd6aJ5HTASHXsEQTc7ho8Q5bprfSpKTj1IXZn7+ZnNDxDi/Q6w7h2hk6U3rEh
         1sfe+W7N+xQ4VxvopyiszZYsCjP/dLKDMHcdFh8LlwjcK5wMPgsfpunQpk2iSYtI5i1m
         ZlLJEEdya3qVdzXgM6RGUuLVUVuaFTjPQ1tKaN3qGITnQ73VvHKy230Cguhskft++rIN
         snpYGGMxvggFkNyQnl6V5tqIKBlRK+PQH7YPL8isD3qu/B0IIq5qJ0TsciazA/PDtnSN
         63nCloGn1bkKqCGNhjUSyr++WmtRppNWTi8QKe4dZVIAfrs1/yR8sspcZidwryOl650Z
         vAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8ggfbu532abb9m5mtiRHYRE42c/mQ8Xep3Gi4EZj4OJXWkQ5qPxz7xZp0dto+YWJS3GsX0WMCUz2N5af9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz25Sa9wZ04UPthAj3tqJgZNaOJxEpY3+CPNK+FvVDJLUaALxle
	5/uZqKi1T4laPxpwIJHGPFxHrzab73wJ2fZpV5ny9VAIFPlLPGQM
X-Gm-Gg: ASbGncvhy39xabpycIZ1D8Rji3+yxDsx0YUkUQAQic/PyyKvnwZhtKVrTNwdEH9XPZb
	9GS901pehrw8VquhylthLodrMF7TD3Ils5BS1pGjAoy157D+ignnhkR4eTe2DgEL35Lex4i4Y86
	aVMRhEKc/dQ+YVWQoHq22uOM9MfGsPs54yCWprhz3opmqLxJxrw4SAJW0l5wk4jhXpvWC3ovmf6
	aSrIcxCa3BDrw0luj+XiJenl1LCjFwvpo6lmIpS7rN6lzBJEeSHQX+L+f9HPZUejoX9v2nYy7OO
	v1098uGC9FDJmfI/VjgIHcjTrsfOFxB2p5A974xYRAVSCuVBFWPTOyPucWg77aBRGdnmqLW+ItH
	7tsLdeDh+ruLHU68urGcibGLBu5duOsAoFgA=
X-Google-Smtp-Source: AGHT+IEkArU/HVjoiphBvdDPCvGy8fE7knsktSkjFzUd0A68OQYpoVfXVTDmXJAOFwe/nbrLfhrUBw==
X-Received: by 2002:a05:620a:3196:b0:7c5:592c:c25 with SMTP id af79cd13be357-7c5ba1f7562mr3290100085a.48.1742927408168;
        Tue, 25 Mar 2025 11:30:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93482d9sm667748985a.82.2025.03.25.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:30:07 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D275A120006B;
	Tue, 25 Mar 2025 14:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 14:30:05 -0400
X-ME-Sender: <xms:LfbiZ3L0s-uxxazgHFWoD3FXWeadjSNLM0zw3SaLgMy_gH743OhUlg>
    <xme:LfbiZ7KcS4a2rLX4-DWyr244gG5AT-G39Ihj3EIxJ-r4kALdHdc6yx0TZYy1eNv8Q
    dhGK8J64CKp_qCAgQ>
X-ME-Received: <xmr:LfbiZ_v7ceRR6YlXnhxe1dOEbx2LU_ocX8A0Oyl5oWrlwkc8Y8eFW68BJe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghighgvrghshies
    lhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvth
    gvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtph
    htthhopehrhihothhkkhhrleeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LfbiZwY4M-dJxruBtDlVTZCbVkn8kRSmEXzJR3mpjPItwQ9rOxb--A>
    <xmx:LfbiZ-YC8Io--R4sQyjcPuB2gUMfRSWU_6HrFv7pnuUtWFGsh_sJgg>
    <xmx:LfbiZ0B8umsgdONgT7567Kq9-xrbPQue3feecIIV8rIGq8dqwb2fSw>
    <xmx:LfbiZ8b4pedorhcQx9YLNFJ_N0qKFWYlJWuhlIBK_mp1euyq53iKxg>
    <xmx:LfbiZyqdZdJdfe8PEdkbLh1ndOOv_QbyEEEg2ZCi_Xi5ClbAB4ebB2zU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 14:30:05 -0400 (EDT)
Date: Tue, 25 Mar 2025 11:30:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Ryo Takakura <ryotkkr98@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
Message-ID: <Z-L2Km8nHE7Eevis@boqun-archlinux>
References: <20250321143322.79651-1-boqun.feng@gmail.com>
 <Z-J6jE0lHJpWA20l@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-J6jE0lHJpWA20l@gmail.com>

On Tue, Mar 25, 2025 at 10:42:36AM +0100, Ingo Molnar wrote:
> 
> * Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> > PREEMPT_RT."), the wait context test for mutex usage within
> > "in softirq context" fails as it references @softirq_context.
> > 
> > [    0.184549]   | wait context tests |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184549]                                  | rcu  | raw  | spin |mutex |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> > 
> > As a fix, add lockdep map for BH disabled section. This fixes the
> > issue by letting us catch cases when local_bh_disable() gets called
> > with preemption disabled where local_lock doesn't get acquired.
> > In the case of "in softirq context" selftest, local_bh_disable() was
> > being called with preemption disable as it's early in the boot.
> > 
> > [boqun: Move the lockdep annotations into __local_bh_*() to avoid false
> > positives because of unpaired local_bh_disable() reported by Borislav
> > Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
> > PREEMPT_RT]
> > 
> > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
> > Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
> > Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
> 
> That's a weird SOB chain. Following back the history of the submission 
> I believe this line went missing:
> 
>   From: Ryo Takakura <ryotkkr98@gmail.com>
> 
> I added it back in to the commit.
> 

Thanks! Looks like I lost the "From:" field when I post the draft of v4
at:

	https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/

I must re-apply that email as a patch to my branch, hence the "From:"
field got changed. Sorry for the mistakes.

Regards,
Boqun

> Thanks,
> 
> 	Ingo
