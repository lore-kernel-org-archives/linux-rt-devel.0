Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C352F068A
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807944; cv=none; b=UoMAE2VOZc9ZjUC8eVNeimyZGa8hszTiCYbqo3Sg130c1zkQQ498BDwalfqBB4NgQ4KL2XvdHIV/FenfsMdIUqFhDmQvJ/UBr1iVJx4O6s5eELHneNsjMO47v65yFQXFnyEb9Lgbn7ji78WwjpO7ECEu4iWP6q2V57rFdkoZXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807944; c=relaxed/simple;
	bh=leXB5mHyEcG586IzWuBWfTUM4regLFxyXevDN7z6VV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRHPmIlWFHhd/8AB86+sPuacusX5zEh/OF/05PD88UPG9aW+thBUEDpjxcyrI5qig/DAk5oGyGqwl6zRcVPl7qmUDbHzb8j3CF47Iqw0Lu1MM1qSpMELIz1SfmUCCrFpBuPoCsOhYftL16r9Rmz9z0Mh+v1qHGIiAydSJwntNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+F/X+og; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+F/X+og"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f777836c94so459562585a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756807942; x=1757412742; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGHsOt8ECn0wnw6q+d1jg+PuZZM4BobcldkVyU4WYFM=;
        b=F+F/X+og90IfAnVWXi39BH1SV8lecTVwTeRiVEVrKoj/bJyYVdGKsKTGlG9GNsG05q
         4I0K8woJxEqEdYGB4W685lx4sJb2v9rtH9oVA1hIEky+p0ho+oR4Cjv38IQzZQ6wQsLq
         ltxGqdSuQBbZhc06J3fyJYWLRyunU8YtfQ5YNtIKo50NlOV5vHUWN4Rg8HZApdHtUr7Y
         oBR0+HDGwVQTn5jlfIhD1MktIpadYfbCej8ogVvUUSTyUO/zUmf8vsOobkWJsj+FKUOD
         dR46cdAXlqzk9/w5tlUHG9qR7Qkn8kuEX3IyxHy3rL6nowfWv+eMVON5AehPsSqI+O3a
         8z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807942; x=1757412742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGHsOt8ECn0wnw6q+d1jg+PuZZM4BobcldkVyU4WYFM=;
        b=JAyzLRfRBvgaBg7zDzl8MXgOcrLJMYxbLHO9B7TRXvxS48BQXfmPhC0M3LNYNUf5HO
         PlT3SgaDvdtJtIzOdaY3EgNQ219ZwefQzjoaDuPqxm7KwvoihXy4k9YDqk7EX4GQNwGh
         VnFtd43Rv7TRbwU0MmE6sLS+Sm8tP/XernlsU8F2R8oeCXx1a51lZtPHUM0dYUNiKiRV
         0wm1WybWXFvbAFZXOUGDI22ffQwfjQxxFAltrlgXdDPtq5248t3vgUmvV8ceRW/Ur6Px
         Mre01i1BJx/9x979IY4VvBrCtoFwT1A+gSemHnFVtnNOqhPMopitqc2bNDYCaaUNRDvR
         slYw==
X-Gm-Message-State: AOJu0YyJqEpDf+KvD/r7Ha8+WzlyJcnxZbx2vW+iIhzXIaGRl6lHSPGz
	wh5J5axsmYo6Mbuqbzjfv15ygAHd/yFDaEP7g1JlkC+/DX2KsPuTKWjmjS8QbGLqLkms6TJLwND
	zMtjLlTftty0d8qXDV8TfjyVhyzjvRgoMer95mZoorg==
X-Gm-Gg: ASbGncuEHJPbfMw4LDR1JnZqMdqeozg9Z3fnuFktSuJXGs6wKYebQ5HMZpVmpihLDuy
	erqmS5LoP73eMhY7oYK6YOq9+1dedtzXPdTnpbGJTOwUsRv3MI/xKivksD/uv+2cI/KpFIFltfY
	cbTaIml5SoWa7hJ/E/kh/1u+JG6BR6a9KbJNaYNWWBvlqSzWUGmrR9oAK0UTd4DYnFtEFDvcbqZ
	cDcpYYYo/nlubrJDOeWB/DWBzMWmaJpag5ZLpXEnz9rIv/iJq7qesg6O82qtTLJt0lq2+KQp7gE
	ic4a/kTPtW6iv0wbNhxOYAyM11jdxnQHtHFW/4CmVhqkzJQ=
X-Google-Smtp-Source: AGHT+IFURzNV0ZRA2CEmzn4C4F5wx2AglECKri7SC4LbVMFSGvyYHHeEFu77ztNpX9Y8kvIPhBjBOyID6J4vYd3FIlo=
X-Received: by 2002:a05:620a:400a:b0:7ef:38e6:5a3c with SMTP id
 af79cd13be357-7ff26eaabc5mr1250719785a.6.1756807941715; Tue, 02 Sep 2025
 03:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de> <20250901163811.963326-2-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-2-bigeasy@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 2 Sep 2025 18:12:10 +0800
X-Gm-Features: Ac12FXwFEtKBWDDwozhX-PpQ1R9Twfd2v-7LcyNEG9PxtZQZ5ptbapJ5erNEG_M
Message-ID: <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Tue, Sep 2, 2025 at 12:38=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> While a BH work item is canceled, the core code spins until it
> determines that the item completed. On PREEMPT_RT the spinning relies on
> a lock in local_bh_disable() to avoid a live lock if the canceling
> thread has higher priority than the BH-worker and preempts it. This lock
> ensures that the BH-worker makes progress by PI-boosting it.
>
> This lock in local_bh_disable() is a central per-CPU BKL and about to be
> removed.
>
> To provide the required synchronisation add a per pool lock. The lock is
> acquired by the bh_worker at the begin while the individual callbacks
> are invoked. To enforce progress in case of interruption, __flush_work()
> needs to acquire the lock.
> This will flush all BH-work items assigned to that pool.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c6b79b3675c31..94e226f637992 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -222,7 +222,9 @@ struct worker_pool {
>         struct workqueue_attrs  *attrs;         /* I: worker attributes *=
/
>         struct hlist_node       hash_node;      /* PL: unbound_pool_hash =
node */
>         int                     refcnt;         /* PL: refcnt for unbound=
 pools */
> -
> +#ifdef CONFIG_PREEMPT_RT
> +       spinlock_t              cb_lock;        /* BH worker cancel lock =
*/
> +#endif
>         /*

Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_unlock()
and rt_mutex_wait_proxy_lock()?

Or is it possible to add something like rt_spinlock_init_proxy_locked(),
rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which work
the same as the rt_mutex's proxy lock primitives but for non-sleep context?

I think they will work as an rt variant of struct completion and
they can be used for __flush_work() for BH work for preempt_rt
as the same way as wait_for_completion() is used for normal work.

Thanks
Lai
