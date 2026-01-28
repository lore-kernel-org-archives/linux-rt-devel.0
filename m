Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52633F364
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591428; cv=none; b=GVikZIZzPSlxrunYG1ueCkmsrWRrfMTxNqSwDnm/JIMLZ4hwdFhpDg4QRU5u2JZV/TuWAqUSlENDD2cE/LGG4h+wqG57J6GS1xErMIuRTiRWWmQZEU6F7bMa7za5tbohjeGdqqswC+JXQf5SwEJjGJm3tcSl6IeiPmey7TxiVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591428; c=relaxed/simple;
	bh=f8WyNmRVlw3H/8V0zjmzSohVz5OJZvS4EvUll/vUhDI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcLRHCwHOMEf4EMC5szt5Vj8j9f57SX4E7jIwSaDOCZiOfCnwcy8DlOBwpT+7Rl9HPJJZcqmM3IkLGKdPy2zR7HihzJdHVshv+rTJ4xjt4Z6I3T9ZjHrTn7Rwbw/W1jSCYP3Vrl8nsh5jjrOA8AGsO/OCEvl9juZoaXDQZF6/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzfplOpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzfplOpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DD9C19422
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769591428;
	bh=f8WyNmRVlw3H/8V0zjmzSohVz5OJZvS4EvUll/vUhDI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kzfplOpRVoJS6qmlhQcU0jc3pgg5j8KtSU0MGP2deIi/NCAccrjGLGgsJwb8IWyhl
	 RoQyhSHcqwXt7a/HSRYYdBM39kDEBlCIKVf5uPZZPbJMdfHWgg71qs/29c41wz9iQ0
	 4EXCSYIeSC0MoXAoQLHh8+cPElh0q1KlhaTAdaYYmMjKrIdxbrUjVIa42GU4sJ4Y1h
	 25ZuCIjEbREL913gC1GlsyrF4WMkcGSyFk8lvT+TOjgxlofqASYhVd6ypaHqH4ggTb
	 zrQ5P95F187Ok498ntIxxZBbATIMtxMWOy8yMyN96UuDmwsv6B5CtKwDhDjNoUfbju
	 tlJZ/aSyflbFw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59de66fdb53so4781074e87.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 01:10:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTbZ8vpPJr2BR717sHFFXeEZyw3gnZ9qAynmmDD3qlsM15N5eE88QZI74z5t46ieRL6hiyYlC6QpbjbLfwtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB87zDHPet+oCs3i2CyifXddMUCVImr0NJZKQmY3Pt0G0ZFzh7
	oGPiEv92M/0AjGUypauUiUPBXFvNGu0MfR6r+V8iypRKCoQufE5M3zDkDZ4n1v+ta+yVAZD/X/O
	DfMKNFFOznn57ndzGsaaIp+lwormgsUNtpZz59Oq7BA==
X-Received: by 2002:a05:6512:2307:b0:59e:340:e557 with SMTP id
 2adb3069b0e04-59e040185d0mr1857162e87.19.1769591426871; Wed, 28 Jan 2026
 01:10:26 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 01:10:24 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 01:10:24 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aXkTsMqZ4iZyVM0J@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126094209.9855-1-xuewen.yan@unisoc.com> <20260126095024.ZEEwNmlk@linutronix.de>
 <CAMRc=Md+ptvRvknV7C4g2W_vpkfQmLkanKUqXzM8eYSe5ns1dQ@mail.gmail.com> <aXkTsMqZ4iZyVM0J@black.igk.intel.com>
Date: Wed, 28 Jan 2026 01:10:24 -0800
X-Gmail-Original-Message-ID: <CAMRc=MfKLhD40X7Xc-U=tFjt=ipsDk43=cieb6AU5K7wLzVA=w@mail.gmail.com>
X-Gm-Features: AZwV_Qjg7S1wP3kgQ8eQUETsp7fF7VKxj1PP5qXsIOgTyYd7zqfDzDaAFt0DClQ
Message-ID: <CAMRc=MfKLhD40X7Xc-U=tFjt=ipsDk43=cieb6AU5K7wLzVA=w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sprd: Change sprd_gpio lock to raw_spin_lock
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Xuewen Yan <xuewen.yan@unisoc.com>, linusw@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	ke.wang@unisoc.com, wenhua.lin@unisoc.com, xuewen.yan94@gmail.com, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jan 2026 20:36:16 +0100, Andy Shevchenko
<andriy.shevchenko@intel.com> said:
> On Tue, Jan 27, 2026 at 10:07:01AM +0100, Bartosz Golaszewski wrote:
>> On Mon, Jan 26, 2026 at 10:50=E2=80=AFAM Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > On 2026-01-26 17:42:09 [+0800], Xuewen Yan wrote:
>
> ...
>
>> > > There was a lockdep warning in sprd_gpio:
>
>> > > [    6.258411][T329@C6]  el0t_64_sync+0x1c4/0x1c8
>> >
>> > This could be reduced to "BUG: Invalid wait context". The other bits
>> > provide to added value.
>> >
>> > > This is because the spin_lock would change to rt_mutex in PREEMPT_RT=
,
>> > > however the sprd_gpio->lock would use in hard-irq, this is unsafe.
>> > >
>> > > So change the spin_lock to raw_spin_lock to use the spinlock
>> >
>> > spinlock_t to raw_spinlock_t
>>
>> I fixed this in git.
>
> Not sure if you noticed the above comment by Sebastian and it's actually
> documented in Submitting Patches that backtraces should only carry the
> necessary information, so usually ~3-5 lines is enough and not two full p=
ages
> like in the commit as I see in the repository.
>

Noted for the future, thanks.

Bartosz
