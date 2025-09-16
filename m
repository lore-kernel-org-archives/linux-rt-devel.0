Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757C222578
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987741; cv=none; b=UuUGZaeetNTNpHzuOgpv5CMT4vh3g1d2vakmXwEM3MoXC9ed29mVpRfs4p0FObBycN70YRhV3nOWBbjZmWw+b23PHX+ueacTGkmrqYDkqJUEQnLaD7pz1sSqy8dHpPaZS03LQYE+sGnuovga8ZS43g8WrFdpC62eMCXm16/B1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987741; c=relaxed/simple;
	bh=jep2u5VNTk538PUR4KP/b48BjYybUEbcPCBXSSZj1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0ly1KPgSuDkY1EwhB0jU7hiGsC6xspckYp2JsGo/hQUJ6c2PV0YTEdvFEO37snap3W4s4LKiM6B6DdGf7VGVrOyz/eyW7x+shXGtCVtzwm6cBiWTV1yLUJw3RWSKQ5QsTnhimPwQ6kf9zC3Y+UulX7EAdT2iWVhBqgcOAT1wM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTx38Uhw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTx38Uhw"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f28b8e12cso4026254a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987737; x=1758592537; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=QTx38UhwVnTmOiaqm+CHnHcUIZAFsl3wUtnSEF2cPnBtBAAE06OfMnE9dypCiwM/9J
         MNu/K1X9amTtounKLDeq+YG1c4fCABEzGAjIlQaYTlkjS8Q5qHT3ldkp4gmexKN+MZZN
         dR0SUxtYYd/1ca97HDXydqBex18b3nt3IZ2gKR9bilmrnyVP9alicI/8WTQr1J4HwWc7
         pvyWwMsYYlDphAA/X5+LKhtaqro5AtprmSHu0Df77tsFzWsYT2yF7lPKVmoP7kgWEgBY
         A2bx8zdPDTcsLA8fNeQsUOtvqM7dX6/B7rMEij8jJAlqmrh73c3fWpGqMFyLzYtPCjWM
         5gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987737; x=1758592537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=FP848NkpizBFtEPKnsZ6eGeFHZsxmXGvwa+10QDYh5OwppRh4VBGsEi4MnlkCTxnAa
         7m/dEXfHyHVaLJoRVIFuaeg76P6TB2DpXTDBlJXQD0/uu+3aRzlBDibw9EaJ2hPGZlZ2
         DoYtUrdKFL6NLRlmJqIrlg96dPqrLGYnVzaJ+21ARsK9Gf257rptQZLZrKaLsI7KtZk3
         /DRhPy4VOd6vvOq4u1+hBUsAwTr8KyrJxzw4FLfuJsyCEyrfJnnov2C1DkSDU24UXDKt
         fNjXXad9BeJfgG396CjU7nsPlolmNu0IVVQnRlsFh8Y/dswFtTAtASz84xglzSCAxX2v
         1ndw==
X-Forwarded-Encrypted: i=1; AJvYcCXuYx7DWuqdLA2B/crvVBF1AJqbYNeHslKNfGev+IBG/S21MHCNQM9AhvRvshzld2Gf8rVGYrgy0J4c/qAKQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTR5lhkYcF/nhLnAcs6Ij2C7ZZiRRLpo5Oq0dzL30DWGwV7PFK
	w3gCycYvo7rPbQW4sycXsd8zIOTRj+C83TF2y4HudbXfWFMkZL0u8OhyOteoNpiUTuBf6IlGZdc
	he3BkvFDCNttg8jIbadr8IoH1ktd2f54=
X-Gm-Gg: ASbGncu1o5BkaS2qJtoJsY4NT2vVIHHlfZAXNRX8mv1Y6HsyhQgyrFLaExCb9M+lVZp
	GKwz4ZK/PonapFokIdC1bQpRNo0IEOVvXQu/tPMO8fIgk0vOe/Z4Aqe2kXbDi2gWXZX/qVKmnq9
	S6DW/yCKFhw0c7LZbzsmoezalNDHwnZ2RdaQeir4ZgN2kin+nrBtN5/R9A/NvY0Wnf6Xzrs84QI
	ZTyYCmb
X-Google-Smtp-Source: AGHT+IHJugXW7PgqM4C561Es6pZ+yMEeghRxxr249HgOnA0uY3PnwVnYPJp7RZWq/M8Ro+g8NAKFEnS73k9uc/Q2N9g=
X-Received: by 2002:a17:907:969e:b0:b04:6c19:ed8d with SMTP id
 a640c23a62f3a-b07c35bdfa1mr1378153066b.26.1757987737286; Mon, 15 Sep 2025
 18:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915134729.1801557-1-dolinux.peng@gmail.com> <20250915144052.VHYlgilw@linutronix.de>
In-Reply-To: <20250915144052.VHYlgilw@linutronix.de>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 16 Sep 2025 09:55:25 +0800
X-Gm-Features: AS18NWAOIt4gv03twwvlmnUbxI3Di3y_xFKnQycCNlJ75R-ks7_KB2ty8Keq5J8
Message-ID: <CAErzpmsW7=3RmLZxByxVD+vD=FV0YDF6POHVZZce784r7jMQyg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com, 
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org, 
	trondmy@kernel.org, longman@redhat.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-s390@vger.kernel.org, cgroups@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-09-15 21:47:29 [+0800], pengdonglin wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> > consolidation [2][3], RCU read-side critical sections include:
> >   - Explicit rcu_read_lock()
> >   - BH/interrupt/preemption-disabling regions
> >   - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4]=
)
> >
> > Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regio=
ns are redundant.
> > This patch removes them, simplifying locking semantics while preserving=
 RCU protection.
> >
> > [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU=
/rcu_dereference.rst#L407
> > [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.=
com/
> > [3] https://lwn.net/Articles/777036/
> > [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@p=
aulmck-laptop/
>
> What about something like this:
>
>   Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side
>   function definitions") there is no difference between rcu_read_lock(),
>   rcu_read_lock_bh() and rcu_read_lock_sched() in terms of RCU read
>   section and the relevant grace period. That means that spin_lock(),
>   which implies rcu_read_lock_sched(), also implies rcu_read_lock().
>
>   There is no need no explicitly start a RCU read section if one has
>   already been started implicitly by spin_lock().
>
>   Simplify the code and remove the inner rcu_read_lock() invocation.
>
>
> The description above should make it clear what:
> - the intention is
> - the proposed solution to it and why it is correct.

Thanks, that's much clearer. I'll use this commit message in v3.

>
> You can't send a patch like this. You need to split it at the very least
> by subsystem. The networking bits need to follow to follow for instance
>    Documentation/process/maintainer-netdev.rst

Thanks, I will split this into a series for v3.

>
> and so on.
>
> Sebastian
