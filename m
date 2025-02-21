Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838852528EB
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166994; cv=none; b=qQBSkoP8FueXN9zGXm9XJApbvRE8uIOsskOH/F7eR/VrOnq/qE5yBIa+nEu8CoEUZrNJ8QawriXjBVd+0ulVSsgKLUD1wJkI1KASvSJzNkcgN3uymk1LlLJOBw9RiBnSZEbLMIEAE3Cl4YKE9eCixNARcPw9mHYPeq1TLxKvUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166994; c=relaxed/simple;
	bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a25+/13HMYW8IJNMdUnQt/I4deTEpbv9GBaBixcEYEC0crW0b4VCzt5JvBLijjKSiFjQRs2KCptBX0mmMBRxefldt8vef2lGSsorT9TN8coRP4ZhvEEfX9sl32R07Cl+LjIhm+/nFVSTg+x3S2O8YXX+J8DxFku7XP4JAk3CdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG9Dbwc5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG9Dbwc5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471fbfe8b89so53931cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740166991; x=1740771791; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
        b=CG9Dbwc5qfOXMCe9R9nYLLEMJTVa9ApIAl4vgPqIq537hTfRuz37AEkhVpsrG7Vk8v
         6Pm0U+ZYYjb6464CQH4Vy4JFzkMAhHRh2spC4WFsG0ZD/A/3VkIszHhwgHmWaj1PySG1
         jwIHH/widtsiKytLoDuqgkqO+BjEujrRz0sr2BTwMZmDM3uKJsLLP/ZJMzl2bGZJ1INd
         tEHLMrzXAYeN8LlCOGntYSugbzzC6yijzucgU1pzjanub7YjdV90VOgEqeKjJgluk0YV
         Oz48IuTDG68mKOfLg2YenjF4hAFxPgKOLwjK2rn421uM2hxqWUC6cBaEA9JG3ouBjxPX
         K0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166991; x=1740771791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
        b=fShRuAxcL8rQAxQiFISGQskh3+OybExErvGQ/xzwVuLygj/GbCAvZCHJ+YMMuRQFKX
         KG14V7qggNee3uqngj7OcsWHGyQtlwPLIgNZ1KxzxTNkgFAsEFrp/rqiaIrdDkNXv2fV
         DcKfKg1MQrw/rmpIf9IsK6Td/9IvmQWRetXDGvGmT9BQBvS7WCvxuuQ/oPVCeDGP+bzJ
         DR1D5cuQl2MWJppQwtPge0VIoCuOXjJWUStEqF6q28zfGT7fHeE/sqgucxIJJrQDJs/1
         g+c7Mv80zTQiw2OfPdT/Y4bzGjoxgmv3epfTgnYoNJuAb2OaSIgD9Xhg+8HceZ1LJh9S
         hk/w==
X-Forwarded-Encrypted: i=1; AJvYcCWy1kNz0H6c63tQpZLRnJy5LIB89Od1K+wTL27VzVf24/N7neTrevMyVfFwfYr1qmf73iZX9CHLTeUGR39jFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDRDx8ump9xhySU5rhAlTnmWDKeUZt7rrGGdIp2YhrPDSuDTWQ
	56SWPmrMinj10+GrADeUhH1PPhoWODLL/aId8MKW/A5B0loF6ucASlhFipBGi8ieoRxp/GOVyvK
	E0ztBC1MxZo9195TFmSd3JftEi0LXsQ33VCX3
X-Gm-Gg: ASbGncsSefEdDOFM10Ermi5jpixnpCX7efxZ8DCgbq24vS//ASxFovYD6uUPujhyP7K
	WcTu1RW+HfVGHi+qWKUKPFYhyN7f/y729N8TWt4/AbnqnyOQ/o5700ckyG8HvlAvM60Y5IhM/C9
	RKX/IVLGPl
X-Google-Smtp-Source: AGHT+IEOnjZFiRhGxpDJtRI7e1BzpTxFXUpSnGjB68hdpcYJt/skKBjWPsMwz7ISV8LbfReXO+Memq+SOXK0w7M5oLE=
X-Received: by 2002:ac8:7f4b:0:b0:471:b96c:7267 with SMTP id
 d75a77b69052e-472335845f9mr206901cf.20.1740166991241; Fri, 21 Feb 2025
 11:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com> <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
 <f4fed3e7-bc64-4717-9939-cd939e0aceea@amd.com>
In-Reply-To: <f4fed3e7-bc64-4717-9939-cd939e0aceea@amd.com>
From: Josh Don <joshdon@google.com>
Date: Fri, 21 Feb 2025 11:42:59 -0800
X-Gm-Features: AWEUYZk5ruyrDHbpBVUV2yisf85ZTa8h0dd93_WN7GhaYhAD1eBvGpXDW_9DlNU
Message-ID: <CABk29Nvn6qwfZdN-DQJs+KUSch=RcJ7Fa+S08a9tiwZvDEUnxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:38=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
...
> Just out of curiosity, have you tried running with proxy-execution [1][2]
> on your deployments to mitigate priority inversion in mutexes? I've
> tested it with smaller scale benchmarks and I haven't seem much overhead
> except for in case of a few microbenchmarks but I'm not sure if you've
> run into any issues at your scale.

The confounding issue is that we see tail issues with other types of
primitives, such as semaphores. That led us to trying an approach
similar to yours with treating kernel-mode as a critical section from
the perspective of e.g. CFSB.

> Is it possible to share an example hierarchy from one of your
> deployments? Your presentation for LPC'24 [1] says "O(1000) cgroups" but
> is it possible to reveal the kind of nesting you deal with and at which
> levels are bandwidth controls set. Even something like "O(10) cgroups on
> root with BW throttling set, and each of them contain O(100) cgroups
> below" could also help match a test setup.

Sure, I can help shed some additional light. In terms of cgroup depth,
we try to keep that fairly limited, given the cgroup depth scaling
issues with task enqueue/dequeue. Max depth is maybe around ~5
depending on the exact job configuration, with an average closer to
2-3. However, width is quite large as we have many large dual socket
machines that can handle hundreds of individual jobs (as I called out
in the presentation, larger cpu count leads to more cgroups on the
machine in order to fully utilize resources). The example I referred
to in the presentation looks something like:

root -> subtree_parent (this cgroup has CFSB enabled, period =3D 100ms)
-> (~300-400 direct children, with some fraction having additional
child cgroups, bringing total to O(1000))

Best,
Josh
