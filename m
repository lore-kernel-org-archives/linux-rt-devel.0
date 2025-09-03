Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6B2DC336
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884623; cv=none; b=i1gJIYC9FKy1DB7DsyjIXAMcMX//a3AmXhKjcVlbUaxA642FEb/3vw/RFAiBNTsTpWwt30IO661X5y7ucia/EvRNWua4YEEAPAWzBPAPfpEZpKdOd3KFnrq9pwR+TAWctSFyqk1npH6cBWNYKExnisomYR54FseADDujiZiyoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884623; c=relaxed/simple;
	bh=Ym2nm4+ptYwcy01eFZCDcoTVPR0dPfmqbPNzT14L1ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfinxP/MJ3OljGvEaxDD4SnlL3ghezr4/6Gglpr5l4j5fxTKfc/8+7T68KBub/+Pr1IESg8zx8zULiyIgkyI7jB7ymUzmJjJtl+8OgU7rBu/F2f387BvAk8QKCs588MT70IbqaARlqPqoI3QuxpbPSaxOw4RkTWBoqa1+0fm0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hclMsstY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hclMsstY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f777836c94so541065785a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756884620; x=1757489420; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqFsjpzclyFYWvvNxQhyZs6NRp9XCa/zqGcXA4zBk2A=;
        b=hclMsstYgXyu0/xk9QW0+WxtHB38H7od/4V85LS8AYWsbCsW1lpKBuUsHzrcucFhVX
         CTzX5jTmWjbJfiu8s0rqRL+2fR2PnDGV2fK9lDr81W7kfuOFWP1bCC7kJVwmSh9RfUWm
         SiCwyw2ldwPfY7buhfFJu7mOA92qd6tVPeqIr32bUuu0y5WyMMuTTx3p5PbDekM0MocF
         9R4dJNmR92mwHLUcU3PJjhz0PRye6ejYD4BmleMd2J7vvZYUZ9gCRqdUUSwE/qFIiDlW
         8vnF5/2+lN5LSd2ARPnzcv1cgkaRQHWxq51VDejOFzZgylFiD//1Q0JyO303kasiVfNo
         Otzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884620; x=1757489420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqFsjpzclyFYWvvNxQhyZs6NRp9XCa/zqGcXA4zBk2A=;
        b=B7IsnSy9R2xdJ/rCyMwyCfXsLh2EbgzzUiQOugjI/xXqqjGdZjLwz8MDdzEhbsXknv
         WVAnhYdSNHn3Wunc2FAimmWwZ1nfRxh0eWRKJmMnjF+o266wOUgxpE85lzhUY2y+k3iK
         N+xQo8bs6/VmabtAjLnFvrHvywrJyrnUbMabA/hlzX4aBuiAYvOerFz7hZDQLdiw6rgz
         ugLLdj4Fc2xd0ZmVSfxRrMkyJJCOGL5R1tzZkfDv4dFt1+3EjLxlxfmPdyxU+m8hoOWC
         qPEgE+o4V5ktx3Q0hTM01X0UwZo6IOMn05oUZ6zRbjXxcA+X4XyWCZNEs74FffXErpD0
         chQQ==
X-Gm-Message-State: AOJu0YznekiPDdG5MXhKxExwJ1x9CJc2ig4T8XarrdFfTk86ShBe/s8C
	4jJdCDqZwJR6lzBw9778Ps0SP/OaapPbI0pnA99wV8PSK+ntlo+buKM/pHC500I6ZEtvYIUJfJy
	/SSd+hiHhzEzUpEJvloBZq9cF/3R+xaJ/hlgQRXc=
X-Gm-Gg: ASbGnctbVX6t4j1uDy2g3NwC6zmGUebrZ5sMpN/4roM4LMoXtygRJxx8cHIpcyT2qml
	y1mYWiUBUImvaqE6XN5n3ojCJHWm6oejKZoAhKAePukeSttjpkzNobCfUbrhlbDhK84C17kJ4jg
	WwyFr8nm64e/0HXKvr6akvYKIFDsdIha8mWZLsrs2F/ulKIgs9sJBz8LilDNSFiX/0MFhSazcuT
	eMqJi4ltVlmD60mCCOeQ40TCmlnTPjD9axrt+3N1zbxnHrsL3OHMqn36FxMtrNyYu8rtzPCbwNV
	pVvfuv6qF7yDObyNl+sjmGLKJcgV
X-Google-Smtp-Source: AGHT+IEGnztRcFrrUYFpj7zWNk70BFNzY+kfSfgYy4Z1QRs3gIJvcCDbuvQEWPVeJt2OAdy3dIu7k3f/8RNjEAFfAkk=
X-Received: by 2002:a05:620a:3184:b0:7fb:84b2:274a with SMTP id
 af79cd13be357-7ff282c7665mr1748377685a.33.1756884620149; Wed, 03 Sep 2025
 00:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de> <20250901163811.963326-2-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-2-bigeasy@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 3 Sep 2025 15:30:08 +0800
X-Gm-Features: Ac12FXxZiyTXHFnKDXk2z55vhsiD4pkHxzUm_VzeMHYhmU-LyM_-nQ7m7tfZPCk
Message-ID: <CAJhGHyDrKzG2n77UXh4WBhufFK+crjoHbYUdQ40TGvDcDXugOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:38=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> @@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work=
, bool from_cancel)
>                     (data & WORK_OFFQ_BH)) {
>                         /*
>                          * On RT, prevent a live lock when %current preem=
pted
> -                        * soft interrupt processing or prevents ksoftirq=
d from
> -                        * running by keeping flipping BH. If the BH work=
 item
> -                        * runs on a different CPU then this has no effec=
t other
> -                        * than doing the BH disable/enable dance for not=
hing.
> -                        * This is copied from
> -                        * kernel/softirq.c::tasklet_unlock_spin_wait().
> +                        * soft interrupt processing by blocking on lock =
which
> +                        * is owned by the thread invoking the callback.
>                          */
>                         while (!try_wait_for_completion(&barr.done)) {
>                                 if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -                                       local_bh_disable();
> -                                       local_bh_enable();
> +                                       struct worker_pool *pool;
> +
> +                                       mutex_lock(&wq_pool_mutex);
> +                                       pool =3D get_work_pool(work);
> +                                       if (pool)
> +                                               workqueue_callback_cancel=
_wait_running(pool);
> +                                       mutex_unlock(&wq_pool_mutex);

The goal is to avoid using a potentially sleeping function in
__flush_work() for BH work items on PREEMPT_RT, but
mutex_lock(&wq_pool_mutex) is not appropriate in this context.

To obtain the pool of a work item, the preferred approach is to use
rcu_read_lock() together with get_work_pool(work), as is done in
start_flush_work().


>                                 } else {
>                                         cpu_relax();
>                                 }
