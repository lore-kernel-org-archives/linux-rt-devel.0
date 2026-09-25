Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F2377EBF
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Sep 2026 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309566; cv=none; b=cjueyVwstur/+2Tt5y8iCy4/t8kX2JOYvqGt52mbkoMZAH4PbkYWt8k74HZ24H5zbHs5Z1aSeZ9SAgUIEYN+zEiUH9CicH89blRZ3ntfsATzg4KhCRnriaMr87IfzuPKOKVky4ue0NhKiNSvbJUaU4GUi7ZyvCtg3g1Ya/tLSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309566; c=relaxed/simple;
	bh=fsGAtT13nBoh2p5VgiySeOwGY+0SCDfVVoO5fWNZ1Mc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=cYx8saXm0jZ+VUWo2pmgEGHm+PEcOVbrUIYPUUpv9J4STUz5SLGdxVVTAIkCHfyMp01c3rPBJ6HKn/M5K7wMRw3lvgqczuitkMfvpWd+xsdwkAKAS1Ylp1SbP6yoWiubGpQ8KyuT0M46C5tF/bkahsUXpPAp2pKWvlA0xDnITfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyDOKeq0; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyDOKeq0"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so121148a12.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 21:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790309565; x=1790914365; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4MGTQQsIFwRWN5LVLl2bLnymyqR90tzlWdPdS9c0zU=;
        b=XyDOKeq0D3jRYtVTqqK95wpLGbQ1JzpfGg/971us2zNa9sawuPQLbYg1Pn5M70QLFW
         gnqGg56vao07WY0lOfxldvG9CJst1RMM4T2VP25oDE16sx5GWXqO2hhpW5kbjr0Th88o
         BR+wIOFXjy8Wb+E4yDArMqS9XsKzlY5kP50UIA/9fn3GMeXiSUodWID7gUL80R3e8NZQ
         kWpaB6YpkJo9HIulwhqvwT0dUlmuTRjJ6WGxKbR0STOI1xoEg53ipllA2s57LPKl22Nl
         EuROpXyb/JHovlNRJHNASc83vJPXvpHAM4kaRA5NYbdijQqawKsZCO6DbQwXVXQm5gKR
         54DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790309565; x=1790914365;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4MGTQQsIFwRWN5LVLl2bLnymyqR90tzlWdPdS9c0zU=;
        b=prosJJdcYab2RZ7PqMSnl5ApQ94cwEusOetFON0UyD5YbIZJHDTtEbgrvdejwhcGkM
         3eQMXHCCL2sNcSGa0Z1guuXzqnFsieNwvNy+dA7LTQkxniDKwMZp8O713xOQ8y4vqTsb
         Zmuaq75ptVAiL16/FNpxegzD/EfjcsCIDOQXq/4r8wvqqv/xegGmBXxr5iJf4dC8CUK1
         k0t73pxEiNxizTWyp/mvu9rrPX0TA0OiY5AZBC3stvOTKMUAQGXQ2cBERMSiV1xvAjTS
         qYBeMhDzqP+uECbwnMUoBJBUN/TrH0iZ8jwAmyYAZiA9NWrWC32ecLgigpVP2j+Zs0Fa
         87nw==
X-Forwarded-Encrypted: i=1; AKwUvBxLVWyecEzKIybm9v50JNLuiiUukOgseaD8YkPSK+4L8VY5jMvXyHh7aPYM++HNtXsL8A7/e72jORb6+6qSzQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l/jMgyt706n5gg5gn8v05U83dX10gK6GmchwUjJ2NNEFbvryUR
	MDaS6KtTtuS65MZ/hsE/ge3HVeCXxXVMHPnUekJ8L3xY/ecZaOK1ZzKL
X-Gm-Gg: AYBFou1xam/4lWCmOR59+V5BzNaBi6N0wGLIoyVzLllNO6BhYxpJLRBzehZvqgcP0ef
	0VGIiAOS4UWxEHBxziTyrBCzpNDBcAQCyA5+TGiWteTWV7FzTrnuy1cBPzES3RzehaZHB/96dKR
	sOh3Oo03Mpof2vQeA1YSR3TJR8At611oHXiosVjJyvbhJz39v7AuDKqEZGz74GPM2HqEq/SypCc
	LF+UUr9xaYa986YT8bLv+l9oK6nmYE3wKzFx0Dk+1BkkOfvEr7TLB+DUweDtjVDwfnx2D9prkJt
	pQ8Tlnv+/1XOxyI/+8P7Vu//GOtDA6zbVKsJHXy3wNfVM3Q3q8Mn808vM4QjFoYjHkTd/RnoUuH
	fd7hi/u2s/rB1Wks0BwroPKpEWhU3fANrXOqfGxClGWaN1/6TcwBWCImx+l93ZtRw8O8AclAxvR
	oFQRhpXe1UzijAH1qza0GJ4gNbjYKHFbRf4d2AG33WYQvdxk0TAkyC8BaJhYuTEPk0toDFjCfA+
	wHCQfEkBqf3c4YfITlAqDGVsF8JU1oIWF42J0ih0VGcdRwseOateD3dOCd4Lr9D8e3tucbFpxzw
	IGZG
X-Received: by 2002:a17:90b:1a8a:b0:3a0:c22d:fbe8 with SMTP id 98e67ed59e1d1-3a0c22e01a7mr228479a91.38.1790309564539;
        Thu, 24 Sep 2026 21:12:44 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b998e2bdsm1908663a91.13.2026.09.24.21.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 21:12:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 04:12:43 +0000
Message-Id: <DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Hao Li" <hao.li@linux.dev>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <jackmanb@google.com>, "Amery Hung"
 <ameryhung@gmail.com>, "Swaraj Gaikwad" <swarajgaikwad1925@gmail.com>,
 "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
In-Reply-To: <arIY0wMQjCCsqidI@gmail.com>
References: <20260919171443.90512-1-kmehltretter@gmail.com> <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com> <arIY0wMQjCCsqidI@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 08:04 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> a) Change MM so _nolock() allocation remains safe and can still succeed
>    while pi_lock or an rq lock is held. Existing BPF behavior would
>    remain unchanged. Is this feasible, or would it require substantial
>    allocator changes?

I don't think it's feasible. On RT the sheaves lock, n->list_lock and
zone->lock are all rtmutex based. When trylock succeeded and a waiter
showed up rt_spin_unlock() has to wake it.

> b) Restore BPF local storage's dedicated allocator, and document, with
>    debug checks if possible, that _nolock() must not be used in those
>    scheduler-lock contexts.

No. Local storage is not the only one. bpf_arena_alloc_pages(),
bpf_stream_vprintk(), bpf_task_work_schedule_*() call kmalloc_nolock()
as well and the same sched_waking prog can call them.
bpf_mem_alloc was removed from local storage, because it wastes memory
on preallocation. Same answer for d).

> c) Have MM detect those contexts and return NULL. This prevents the
>    deadlock while preserving ordinary raw-lock callers such as arena,
>    but task-storage creation from scheduler tracepoints then fails
>    deterministically.

This one.
bpf_task_storage_get() with F_CREATE can return NULL and the progs
have to check for it anyway.

> Are these the right alternatives? In particular, what behavior is
> intended from the _nolock() API in these scheduler-lock contexts?

It can be called from any context and it can return NULL.
That's what it does from NMI and hardirq on RT already.
