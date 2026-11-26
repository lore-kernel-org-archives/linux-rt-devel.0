Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725581;
	b=IaDJm/03YSTgU3xhnwYe0xYPB/zNsofO3sw816w2WaJU94Z5NuH+mepLPJB1eMQV7iVw
	 6PRFFv3gwXrSDj+Sf2Nnh0t1MmGReQQz9TqI+hn6GOUOLcaRiwghzBAyJjl5m0T/Yyey+
	 P8Ycd68bF9M12HMlI83EDmZFjFhocDv7Kfb9GKNvsupVrHewtovD/BMI4FW84Tw+5MELB
	 tEo57Wc7cETsdhay5d6F3XVjoUi2qP3926Uecwyovpym9Bi+dC/pslJgL4xwqL5P5iPr2
	 RvtOh0sHqu7P0/WnG5vY7KP296OabKtxKoDC9i/5mLD/HIrKssrWLZPh7OevNzOuRIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
	b=3yUbY0ty0U2OjatcHa76D7IxOL1RhUpZuIKsuitUQJEcowRbHbb1iTT6Yu7s/ZNlAlv3
	 8oRGxEbuRYDZoZ0e0FW0v5+8bTUITnssh3WOFFbfx3S52ebJDAJVQVBDYCI6ZKS/fOZsP
	 aVMli63l6gOQlEUavBRPUZI2VL45s66FyTCgHx4kg5LmwWt+D6IfLt/LxuAFM2KYImOqH
	 4oPoB6pQl2kFEWwXXuA9KuZazqFgsrLljqMH20Mp50pXa3UDksVCE3tkZtt98mNClmsFo
	 5LwQnVqeDyJKnOhGvYn5Lpxd1iEhjTajzMxROFIlmj0FMkeIcQ5x5GRPKZOsv8vGmIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwyDiV1V;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81926606A31E
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 20:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81926606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwyDiV1V
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f041f88577so40510905ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 12:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795725581; x=1796330381; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
        b=MwyDiV1VKK98jPJO9WT0VCfQJjvB7M3+WAtO1EP7bHlLPx0xTu7OA/cuymcH9zJdlC
         QBZcJkntROJhYet1bMcpJtkLQWcsNnwLiTPWxpRAYx+bSAWf4Q8MIApfR0vNe8HduZFS
         OBxV+rnK0+WpDSBZ63DFpu/o6wgiRDZo9Ia2Hi+piBYbYjnAMTDeib85iT78YtyCyLZL
         8j/5/ixij49iVMUjKhoNItZYvcbucZ8DtsCm0O7GYPNmYRkrdV80NpWqh8ScacJGe9zV
         aVaVS2IlGF/36k1zg1jFYXd/HPgdiE4QwVIOQZG7jKKeUpnUpTQW3xqh2oKBlAgOM3ya
         mm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725581; x=1796330381;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
        b=fM9gx4DqxvAWYUJhhCFJKd3kn4sF2MvNAa4lFIl+vM875HxzaUEEfa9KYsw5bJE4jv
         Jsvjrq1VM832WFgYALw5nAX5japiDNLHFbsT6dS3ZAuuiMVegQmOZ6YoNWmolcvedGzP
         jns989/HteNHGBxUQGf/Jh9bZIzM2dCagaSL4docIqiUXEgvx3/ypPZxS/D0PfOVpNMt
         poyv2QkQVzoqvQuLgJTd5EuObJ3xOFvHm3ckIjHi1YDfIrHfWrDFPmQmLHYRwsfFK0/Q
         hDnmeTlRRgmH+pQD1DD3YxbJIEe659I3zZXOKaV30a/cT1tSgCd95kk41zuTzEodMj/d
         Goow==
X-Forwarded-Encrypted: i=1; AL+hErHesxHSxfbIcSdnoUlbV3EQMaCrV38le//Ly2rxTWSm6+9fpMhFpc4jfZngTHA8SPOrUeX1bOnNWI96q4XhCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/S02avSNOrMzq/Z/9FiX0E8U/lm9IswswJ2PTnV6BF27TM8qku
	xuaU+jjo2YFNTLHoA+y+7RXVRLUdllGJO9Ui2vNyCA7MW1Ft+4bl+2LY
X-Gm-Gg: AZFdTZe4y6asrCx6H7tLpqSXxgGWrGPDTbG0bRt+0DrUm8FrD40GQgzb8iJmYNYiXFp
	KEeySgIBRPPw4Yrg6hSNw0EeOM8MBW+0Hs/UU1hiS09+mqM0/SbVVUhfjJzUFLloWiDFTcaMdkX
	AqMvnTwruEHr5qrM7EydSM0ztAalHmOHptFL4ueeG7iSWI0oP5FPlK2pRydp5ojxJ04KKnLaZy4
	hM+mOD7Ka2IVuoiBBHJmWoKHnZhdjaKcy3OR7XQW8X3Ei/eFAe3pk6F2HVR+Pk4ce3ZCaS5hede
	cUFpjN/m0PfTsAc8BqeO2UPXjRFRWRzPm73G3hYVU8zurfkpdX+sJHRKLU8obD0su/XCNH34g0q
	Z7yhz2Rzg43S/7VAYahoyu7GUXvCI2e0lv/hZEwqOvzjM4s/uRjkKM0tsJmd4iMmNywTXaXr0RA
	85NUljZbQSF1lKV5fO3dq/DC1b8wfcX0qMFoecmEa7VaqagtIESIV2nxtv+DaRHIi0Sj1ki/L3u
	O1+yaMsLE5AE4n0iBV3C+6fun2IYqC4ScEaVn5EOpcf6KjySkNU1ksG1KM7iS3BFwFzTE6SkxUU
	wK5nKFxXIzXrOPKh3/agqyPxfR1Xbsq1qwR2dB+UZZBMw2+lB3lep9y6ury/IyM0OmyV6sW+GQh
	YUiOzZdBS8ccvm1d5KUkd4BSvFxCh7kZHgA==
X-Received: by 2002:a17:90a:da88:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3b41c982dafmr20430646a91.65.1795725580807;
        Thu, 26 Nov 2026 12:39:40 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d026d6fsm11352777a12.19.2026.11.26.12.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:39:40 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:39:39 +0000
Message-Id: <DN5FLAUM107A.TFWY9O1V23F3@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "David Hildenbrand" <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman
 Long" <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>
In-Reply-To: <20261126094403.GA49833@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 01:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Allowing this on !RT makes people think this is 'OK' and then the RT
> people get to fix endless crap again :-(
...
> You're actively creating something that doesn't and cannot work on RT.

There is nothing for RT people to follow up or to fix.
The diff doesn't introduce any new failure mode or a path.
alloc_pages_nolock() works this way since v6.15.
On RT it returns NULL in NMI and in hard IRQ.
It allocates in all other contexts.

The API that people call is kmalloc_nolock() or alloc_pages_nolock()
and the contract is the same in every config:
any context, and NULL is a normal result.
The caller's code is the same on RT and on !RT.

> Locking constructs should behave identical across the configurations to
> avoid divergence and create problems.

Conceptually I agree, but my bot points out plenty of practical
RT vs !RT differences which are way bigger than
this internals of kmalloc_nolock():

  where                      !RT                        RT
  -------------------------  -------------------------  ------------------
  debug_objects_fill_pool()  allocates in any context   preemptible() only
  printk(), legacy console   spinlock_t under raw lock  printer thread
  vmbus_isr()                spinlock_t in hard IRQ     irq thread
  kvfree_call_rcu()          uses kfree_rcu_sheaf()     skips it
  local_trylock()            works in NMI and hard IRQ  fails there

