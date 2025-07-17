Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D381EA7DD
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768175; cv=none; b=rBP45xS4Azmw31IqEaPsMezjPBqzTepsK/moXXENMh7nB8LZcL4w+t6bQEbdn8wTjkTpF2JPtM9W3bdx25T4WTVM1uJ1LPmLXVHNf340wlaygWqT96yVU1c3fEPHZ7HVs9f9Lrk99ReU9dw6ObC6egQviLU3XeXO+nssTAmzUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768175; c=relaxed/simple;
	bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aa30fPDv4WZLFiAKrySSwa+MxXZcCcGP/uBFFsT9EGE/6q0YCNNulOOGdLm4Cgm7ZiUemumNbS6jCIBdtaGBWdv9lqp1qKwiMGTDVBhx+SysKOINR3rCmlS4iLGFEqOUSdLp/nPL+UL0Wx3vVfOeAM8tV/8zD/WQZhsfX4du6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClGHE2qC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClGHE2qC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54700a46eso713990f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752768172; x=1753372972; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
        b=ClGHE2qCU+3R62M7sHTAqWQZ6IE5N1gP2FeipdEj7HSnJkb722G054cYX7sK5RI3z8
         ZQWMM85FFIgL5lGgQ1+zen/ADfGxUf0iiL1g3YcztstmTRn9Oa9gHePcCHCJbBk3LoMl
         PPe5sHGrRBGA/G5a7MnLNGaQiHIv1VQdUfqxMm5abTKR1plquxfOi7vX2tGfJ31hHa9m
         cuz0yEBs1JdCLt+d6SpmCzWByUntwB2rc4Iv+iSCGS2ZEQeLcJS98w14N3/HV+yO6VG7
         ivHbzyQwd85QgJe5KKL6NqO0BobeIEDKxab3QiyA+vymohEUY+znW7wxKtHHDyElIcDA
         Za/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768172; x=1753372972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
        b=unq4YHLOXPz6ZGb7G57SPVVZua264YBprjTxN+gd7OUYUYDeH7sPWecLX0qoP2mw6E
         X2BqpqqRVGrMJwv4tNmGIUMfG8zQI2TV+2wlVRBU1JH3Lf/SWirI4IRSZrx0RwOwserh
         j0UWHZh1jgv91UQg/qPzgcBAWsvHqqavUVREDD86vHvtfFKC69Wa5tKqjEjWdYz6JzTN
         AO8B4MX2g4WbeYJWQfTM1nSVP4cAPd7jp9mPtlZT5nnpGpMTQvs9ONXYC0tQ3B9nr/vr
         LnsdExeBk6dA47ke4aMuYApg+5CExUTSE5k3IfKFA8De/t4S3M45EBFUt1IyfnmImaVV
         TRKg==
X-Forwarded-Encrypted: i=1; AJvYcCWHTQ9oRyJtICJQkOE6ivxiGzLh86RqL0xV5c+BD45+RnZ93ZMp923L8zDMUiBEYQ9ms0TYj9Y0XcNIoNxjwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ1i1upUt3I1+lqus2rRvxfApv2wci1ib5IZmyiin7JP6JmKPj
	VOeHjfntrokYSiCmEsy0BD5zqUaOFOdazWs4H8iX0kHyevCMTe35xuQKagcHhVvoKlLXjnWuMml
	XhV0BIrRwshhTkrWqNb46V1BQfumSPVI=
X-Gm-Gg: ASbGncsUiHg6nkCSK/UO4SMkREU+uCSOYB0WzrzbI58//bK56lVKcxDgy0c4WR5heh2
	b5o2OZWMN0BVvIsgMmCIEnRUzurVkxeQMQWuSJGIQLTcBKxno3wnQRdwqd6gf/NLmpKkaa+XCO1
	6g+fL3RBxB9aBpaYnGjkNVOv37HW7wbtgDWP9swSNW0GpYv90EkinEAviKOwsGLsT6hb+hSy7Tg
	aVe+3O/bzz1onJI3Lz9UyY=
X-Google-Smtp-Source: AGHT+IFB4oRhHjPDrVl/yc1f8/SNaiIEVoiambFQLKPb9Ka8HTUWzSv/GsYGujgIC/fTAKitGtlYz5Wg0UkXv7BSCEM=
X-Received: by 2002:a05:6000:5c2:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b613e982e0mr2719922f8f.27.1752768171242; Thu, 17 Jul 2025
 09:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop> <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop> <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop> <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop> <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop> <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com> <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home> <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
 <20250717114028.77ea7745@batman.local.home> <20250717115510.7717f839@batman.local.home>
In-Reply-To: <20250717115510.7717f839@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 09:02:38 -0700
X-Gm-Features: Ac12FXxVEaQJhegtSLdy4TSHsSZ0PotohWhyaCvWLso-UyfRoShy-xNEqM3ocnY
Message-ID: <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 17 Jul 2025 11:40:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Yes, it is a tracepoint infra problem that we are trying to solve. The
> > reason we are trying to solve it is because BPF programs can extend the
> > time a tracepoint takes. If anything else extended the time, this would
> > need to be solved as well. But currently it's only BPF programs that
> > cause the issue.
>
> BTW, if we can't solve this issue and something else came along and
> attached to tracepoints that caused unbounded latency, I would also
> argue that whatever came along would need to be prevented from being
> configured with PREEMPT_RT. My comment wasn't a strike against BPF
> programs; It was a strike against something adding unbounded latency
> into a critical section that has preemption disabled.

Stop blaming the users. Tracepoints disable preemption for now
good reason and you keep shifting the blame.
Fix tracepoint infra.
