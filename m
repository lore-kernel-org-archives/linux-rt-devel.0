Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445050;
	b=m8BumTCm8u2VTEuuwjJFmU9u9FkKcCcHEL+dsQvedDbfUANTGglSFbi4tFAz0lrHikzB
	 bMwmC2w5n0OfDaP71xBSt4iKedR62kOU0hcTTMP5KHj/bM535doJ/lbOuKD+mKC+Cxl4Z
	 sJh6eBYslQZYpWIonAK6/x/iAnh2odABH+B1wJVtsqEW9HArQ7EMpL3e/4meVMUW1j1r3
	 ON4gu1hr4brf8QBlrkqwMBulfe2/BtHSaZeMYrEg3O2eQDGXuklZ7hy5lcSSY0cCg9bUu
	 z/uOdO+osT1BJ9c+I59Zh/iQiWjVmk3om+Q5dyESvhAQ6SQ0EZnnjdBhXrRuoaQabng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
	b=qqW0CMEN+/XM6UIvkLI2GkK0PEbZXmJpiZlm3NHmhh7L1lHVZlQ656LPWY0Z8CF5lMgF
	 nkAZHXg1oF6NVE++Ywzlr2Es9SLx8pxrctpn4Z4LpW+kU2Rv+sj6H9M9yGYJXscnsCJV4
	 TQ+8flUjB2pkK81X6e6qcWuU3KFPR3Oqm+o9wNizAU1bmH98vmdsdHieqSFg+TwNaOJrI
	 7aT02hHD3obvpcmcv6dhGAS+ybNn56EpU1KRh24fOTBmt8wsgKwogrBSpuY3HA85L4J25
	 wHdrHwf4qmx3t31y/5t/gj9OkSovHwZEYzAsWvEvZ2WDRvGbS343OzUvcO7/icKGhwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYlqZo80;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73953606A31C
	for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 11:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73953606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYlqZo80
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so1257293f8f.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445049; x=1794049849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
        b=PYlqZo80mLE55wXIKQFUeEuSRkmB9jinwsibz27378ySnKFLRXmDf8WqQByktYMPaY
         yMJ1tL81R74512rMvKjK7X0tPRr7Y0c7Bi4L8M+Ih2ncLez2BztDL/5T9KVq7pvcjax6
         65sRdA0svUQqOMmY0rOjLZREKMmTyjMeFQz1thSFEsV+BqRifN9101rD5XoWwon/wfTL
         n2ys8NjvMmhK8+tO2bCFmc57xT9l96g+t+XnZC0R5VL/B4TPlVV62/Vss24kiizD4H3m
         jyIkubCvoPLwNfLgNlG5TlXUE9FKmlcwmIBx85DD2PKEIQ3/YTfUQcDWypoyrA/EBFAb
         1VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445049; x=1794049849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
        b=IgSMz7XXFH2zVB8eVLDsM6Kc1cMPsKq+2OJxzb56K/O6VOwdo+5Hpj+Ncne0G4xfYz
         wDet4bmcAnHCdQIueWxIQkLRiCwrq/5V69LL8a/WOxi1VWhpFjkRpHjtATUSfWewmuU5
         qolggeHFMvFL63274BObR7HgaKaq82nUUp/H/2W2P1augZmphEQ5TRZTBa73yyxqjKjf
         2m22nsTKYsVqzu+eDxOlLk4U3OK6vhc0FG7BcQEOHedSlgggr5FBZ0meRjRJNTqBmK0p
         3bHP9pKXZsK6mXtvD3XK0kj/pILwa+FDi/Nl6GWiUDu352sofWB52n6QsFj1IM8dK+6I
         Plvw==
X-Forwarded-Encrypted: i=1; AKwUvBwc5OePstV8anMu2vmwyQVtvrZ+jZohtMtRKi0nc39BJkIRBBmaeygySACq6+kpZ0ewFZHVyutmE6mVIhb6PA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIG0lD3s4YwGYNXbuaFW6rbc7ruvWkc255sBf2F3/lzZdV5yAvc
	y+NOStR7Egp/QQmP+iwJZnrAZ6ZniwDKYv6bMVR/L/ysa2J2mwxInkxz
X-Gm-Gg: AYBFou1UIksMWMeuUPICmlNNcmDUZeTOQp6ePjvFJweQtEsMQFY1zEPeN/sIprzdv/V
	/mx5nvhXDUjo+QhDwoySTVr9G3XsEmxkYtDTzGGQCKUYNwltYBnrOBecRlUGZmhDlndq/FeoT5S
	LQr7p8f6vkwSeO4wznabKOB1ox7od8aNZiqKAaT82h+/0PcIposQf2VYIiPP7ov1anDdPU17XxG
	Wx8pwY2+wtiHt1K6u+2p8v9YHU8LjzDG/7HwctiGK8APiNsLJQn/5xugrwr0ttN4vmow5WJcFZ4
	PWL5mgMPUdzWNR/GfXi1kQwjhdz3kdYXFwE+TjCYT2zukyJFffLqdxMC3iPRQlCXoTpnPUsUv3/
	+BnJLtTs0wZuN5np/po5SC05yfKEWOchZgW8cTYdJZAsq6J42igqFjNL+4WLJHrqJevqR5BNR99
	a/E3S45QxHRkmA8ddEfe62kgztTMy3yw0ITPYFPilv+XmVaYCZVl4eslcpeGMHtYLIoiwrY6gP/
	8dNqvrVf7oICkl1UaeXqxLciqRwHf0O0dkQJgyv0DKLcT+dn4Ur9GpNNlor6LzG5GJx8jbE3E+e
	I7dK2fv67r83/IUdOm1we2N5WdWh/cz4CONdfKcAqcib8uBqOIa/DnvK9HRKO3TV4IS+N5InZHp
	xbSEb/SvbxcfTmbPGHo4Yw2DHAYqGwDMYE63Xho2RD2z7+xZ3zV+buPcaIZaqtpQXztgibxFM5N
	fUOaKkBIfspVNPVwa7Cb5GydRk9DXV
X-Received: by 2002:a05:600c:198c:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4ac151a9a36mr117500995e9.4.1793445048512;
        Sat, 31 Oct 2026 04:10:48 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a81d-e001-9c9b-db33-f166-0fda.310.pool.telefonica.de. [2a02:3100:a81d:e001:9c9b:db33:f166:fda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm117315545e9.8.2026.10.31.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:47 -0700 (PDT)
Date: Sat, 31 Oct 2026 12:10:45 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Hongyan Xia <hongyan.xia@transsion.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] sched: Split preempt-count bookkeeping from
 raw updates
Message-ID: <auXLfz6mFh_uOvRr@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-4-kmehltretter@gmail.com>
 <20261029093219.GH1779021@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029093219.GH1779021@noisy.programming.kicks-ass.net>

On Thu, Oct 29, 2026 at 10:32:19AM +0100, Peter Zijlstra wrote:
> Urgh, so much crazy.
> 
> So WARNs in noinstr code are 'fine'. That is, they should not happen, if
> they do, bad things have happened and we need the warning out ASAP, if
> it takes the machine down, too bad. See the
> instrumentation_{begin,end}() markers in x86 asm/bug.h.
> 
> But yes, the tracing needs to go. But moving that around should not be
> this ugly and also, that will give you the opportunity to fix
> preempt_{en,dis}able_notrace(), since they currently also skip the bound
> checks.

Yes, that's a good direction.

I checked the call chain and DEBUG_LOCKS_WARN_ON() is already fine in
noinstr. arm64 just needs __always_inline on preempt_count() and
should_resched() so Clang doesn't outline them.

I will work on that.

Thanks,
Karl
