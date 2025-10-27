Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC1283FE5
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577889; cv=none; b=B7oY3dNig/Od3j3b4iAQ6FuLB/Ig2M6gtwC1loScjpzthz9A49dqpdzdlEsQ5CKkV+I8OmlK8AT8FLV/2iGH4HjY8pejUxvkKyW2TQYSUTgqsaz88yxHwXj7nmUfEExZgg2L6zd5e8CTt5v3knGVUy4oir9+M75QRIcr3q6XB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577889; c=relaxed/simple;
	bh=lMeTx8WKACZxktYPopjCcShpWfkYkjFg0gmpDilv+Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URKAasuVs6G07tQz6A4gzGckxH9LQezPErkvWKAXIwfivEj7GQfdSArBxObpdOjvWpvej50BuTgPxb3YcqIeNf2YFwQWN2cw6Ulppyb0IWH9T6TefPpayKliFh+BDB2tdAkPCId5O9n6RfAHj7MkdG36bHHtW0sHyNgFRe43Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izy7vqSu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izy7vqSu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f898fso78389745ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577887; x=1762182687; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=Izy7vqSugAz95NNsQnACxgrSJ5nFq81GdmJ7y9RIJs4ht+oVa+qZ/c3pLG9XjRksgk
         EYx0Ja6geTC/DIz/r0KZ5prBzdfZmHY8Qy8LpGHpzOsKV3akSA+B7mWFYSl8APh1w1X6
         3P/PuiPcwTGhgSW+Wm8mkA7Q6mtOlT/dUnWljvjWSsdn9DARXs7dgaUu/SvjK8gAmctX
         2XohRstP4Myn4ex3m/twfk5bR4zADHtCEzMQxot6/5wxMdFmcHv5IUxLBZl0BRszpKz8
         6pIJ1DetY3H8gctTd2WYwYf0Lj0/VJbcKxX24gvyizwvljiNgz68+v0bf1jCLONj5/mt
         lzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577887; x=1762182687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=IcrBAy98Ez7Fgfj+lfylYPYTEMpA4kT+/2ucwOaoyRBrA1OeE0zQftwssiKISrzLSE
         M9oLpi401uL+Xdm18cABXlrBwNtNxgPt+86dp65IvTB8PD6O09DyoY/XsMyfzRVZOxQm
         FjUe0+bJxvpCWjDS+qgbdg9B0hjCKGkXJq5ZlhRD1aXQc1SXWt8ibUmy3fDaQIojoN8O
         DmiqgMwhtK91FL8Zgj90lxJddtRVF1/ZyI+uICq0eC22NQVba2pNiNzPMcmItADyeZrI
         YvwS5pAf6VABvkx/RIGqyuMts7PHhHzCLJjsGZPfZZQaTZ7yogHCyci92BTTAacJBCun
         leXw==
X-Forwarded-Encrypted: i=1; AJvYcCX+R4msxkcArxY0zEQ7Ns3z8JjiCms/Fyp26boDMAUzpo0IeWtLCV49iq24gNuZg9cgV3PpEkLMZbVMdQHaIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPv0hhynhi4IiOCS8Y6xHVdj/7aT0XNEh6uR1TqRmqthINbX8j
	iJ1Gy87r5jValZz/B+8IFMc5iFG+zBqNf7rTlZHWwdndO4sOYiF8xuaVMI2HsYID+LnBUGJp2eK
	MNHeFDoz5R5196MrrwrqtBEw8sTrscUE=
X-Gm-Gg: ASbGncsQ+YfCkq6O1oAqUD2zV017Qzj2W5sOwsfiOfTXwZ9KeICgLzcFpbq6XqQ0W1Z
	KZTJvAe1sraztt0Df272ujFwp7tO7o1dRf77MkhM+ehFTK+rav6E52soiaqsDmdNGuQ3we4MKOH
	WNQob9e4c1YOTlxBIb6/3O3xa6g8g18VQY3ujZGOqLyRrLwv5GjCH/J/TBGKfCsS4RMS6JFobvQ
	kG1tlakrO5bc7eRamfAXiATkNVzU/JiYc9UZmAeIN+uBfdTPeAoIurNJWA0T2xmvIAT/jE=
X-Google-Smtp-Source: AGHT+IHvEIpzH61YALLxG8gdFqbGgN4XUy+Tq01KU2r2KGY59iowe6I+O3qMno8P0Baluus2Jy1haBpQChfxeUeLEjQ=
X-Received: by 2002:a17:902:d4c6:b0:290:c516:8c53 with SMTP id
 d9443c01a7336-294cb51bbdbmr2289265ad.40.1761577887232; Mon, 27 Oct 2025
 08:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com> <20251027081125.n7far5BO@linutronix.de>
In-Reply-To: <20251027081125.n7far5BO@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Mon, 27 Oct 2025 23:11:16 +0800
X-Gm-Features: AWmQ_blGbxBV7S4l3PmDu4W7QBNWl1J0weVSFn5wNOneG3HXMQQG5CZN34vqzOU
Message-ID: <CAH6oFv+pqPx_0Q=bRmoi4vwxeXmt_D0gQGtxprL_8G43j5pC8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 09:11:25AM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
> >             rperr->source_id &=3D 0x0000ffff;
> >             rperr->source_id |=3D PCI_DEVID(einj->bus, devfn) << 16;
> >     }
> > -   spin_unlock_irqrestore(&inject_lock, flags);
> > +   raw_spin_unlock_irqrestore(&inject_lock, flags);
> >
> >     if (aer_mask_override) {
> >             pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
>
> This is the last hunk. You miss the module exit part. This won't
> compile on its own, as such it can't be applied. It might be chosen for
> a backport. A change must always be self-contained.

I haven=E2=80=99t yet developed the good habit of keeping each patch fully
self-contained. I will fix this in the next version.

Best regards,
Guangbo
