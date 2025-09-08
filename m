Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27F226D0F
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Sep 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343738; cv=none; b=OOBgm1rbVRFyKUZzpGvvnUyHmxOvEjNw4NsHw7pSTe/7d3SdcgIOL9G0ytVzk+uMH3uYchUNgQQPl+Tppe6tXcgBvqRGkpjqihNQaNfuBBPmc3SFr2oI/F+0aEOIxWrQwQjMgxizuvEUuQwlHEn7RDErobqOLSiPFXN64Gv76HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343738; c=relaxed/simple;
	bh=NrN2puWX1Om2SrnX1fDXW1TXXcNPXJMRmgjE1JAHh6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5FPkptsqEcMCAYpCFy3YiZZd/rvnZyD05SoH7GRhMaxLMrdqmBcEfnsnoZy4jedj2d+wPCf1gZM6K2q7/wODPsAvdhURqCEnUvMYjnHhe/ybFtbbEnfVzTn1FQF8pv/TdiBtOoD/qv44IlOOrUBLIipy6fcWIoFzRooBLm/8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL/qYTYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL/qYTYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757343734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEWLL5Vbb9k+xSLe/HZhU14b92+dTntX/09oDM7LBgo=;
	b=OL/qYTYCeUPUu/ZgT52ZoWlQFTbdnbJfEDNxVqgZvVnJIcsrQHrnp2Fnkk58eIuoPlZUea
	MGBLVOyMYTjBuLw+EfoMuQaoXACp42HggkwrVxrzU2CHLG5H9wT+lQ2gnvaotKkBg1vDyQ
	n8Bw4sdKX5MB0gEV5Se0R/x/+wkbYVk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-5VM5sfXJMQ-GlueFrmNn7A-1; Mon, 08 Sep 2025 11:02:13 -0400
X-MC-Unique: 5VM5sfXJMQ-GlueFrmNn7A-1
X-Mimecast-MFC-AGG-ID: 5VM5sfXJMQ-GlueFrmNn7A_1757343733
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so97957751cf.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Sep 2025 08:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343733; x=1757948533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEWLL5Vbb9k+xSLe/HZhU14b92+dTntX/09oDM7LBgo=;
        b=IniZbDt69LObW+m+C5LJ/hWStkUXnIrhxkLCvxcunwEOSHCSu61iBBJiKeSb+2CPgv
         mVkdqlatEU5kA/vJebTNhYQyMOg2EUjXWF9LpnxNNIl/rK3tUhTOSqHTwqJrFXJc/V/u
         Jo5nVBgLIRdeu73AqlgOalQcTEnsa20JFWnK6WUh547iYz+zVILc5thsSWwspGZZgHTl
         BN4Z4tzHHNBb6yS1hINK3g8ctY4hXy77TopJV+9XwYB1yvjYjQnbtmWtN+aifreOZuPh
         bPKC0exOWAj4FGShFSx2COuY41LEqSor6Dp6YV5c/Hzb3U/DX7yUTdx8X4fG8WpC6io4
         XKzg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Tz+6LY3y2lGGHMnxCFoLxN6WDWRDvhxzWba0YFSM5VHVXO8yohuy8afoBhu0apaa3wUWSFpH7hEIsCRcLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSmkfE2nYD3ECaAuRSckeC3Q7WA6iikLISyWuiRbpZfPppa+EM
	0FRR8b5zRqeMKQulbsehXumrsgm+0KaAwtSrv1n6WlRiHhbzvjiChseM+/F/vA+mCtRTMNwvXG5
	SqbQGqrt77ga963DaK0X7PYkdE7hkwyEEJ904p2W51VWE1RTNJj9ZjGbg7LcmHSB2gTUM
X-Gm-Gg: ASbGncubXpN8A+rZPSZIDN2jflmf4KmEQKpR2maL/ezIP7Ks31A4XMchyuVmqvyJTff
	dONlzqeCS1HnTqchUkRKFuemvuuvCY/c43XFlmcJ1WKwLoPtwnMV+gyjayI59XS+rCcoUCQnugE
	wO5iUfi0Mw6aIRxhsDDNoKOUm+y4lSg0gnTnWIfmMcpdMb3K2mZjYfNLXkSWuehnwygusMZfJwW
	R4mjRL7sJQfH8okVANMxIgr2F3FGvPBEJXWLzcwV4Yl3mOx5ImyM3F7lb75IQbaJByS6GaI6kZA
	k7GkIYJ6QKT6f2v/f6pdlqFpWyG09xG8tlL2H3aV+PqZLbiIP1Te2E9twxXfQbZ3crklmus=
X-Received: by 2002:a05:622a:38c:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b5f846a36emr96660171cf.56.1757343732628;
        Mon, 08 Sep 2025 08:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1uHxMn1TVqLXTn1Op3nB3byCrcQAFulbDefZ4JeRt6YV1a9xoXVRpsi2KDcyzNZDOkKnjOQ==
X-Received: by 2002:a05:622a:38c:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b5f846a36emr96658701cf.56.1757343731307;
        Mon, 08 Sep 2025 08:02:11 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f652814sm104251941cf.12.2025.09.08.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:02:10 -0700 (PDT)
Message-ID: <ad1f8cbe29e27dc70db136af5888774ab0b46288.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lukas Wunner
	 <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Clark
 Williams	 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Attila Fazekas	 <afazekas@redhat.com>, linux-pci@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Mon, 08 Sep 2025 10:02:09 -0500
In-Reply-To: <20250908075225.sDW_dYzG@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <20250904073024.YsLeZqK_@linutronix.de> <aLmKlVaKSBurRys1@wunner.de>
	 <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
	 <aL55cDBjsNk2xK10@wunner.de> <20250908075225.sDW_dYzG@linutronix.de>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qeWOto5BWD7Tg9zg-7V8D-3Ny_diULWFtPKY3M0a8A_1757343733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-09-08 at 09:52 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-08 08:36:32 [+0200], Lukas Wunner wrote:
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -847,6 +847,15 @@ void sched_set_fifo(struct task_struct *p)
> >  EXPORT_SYMBOL_GPL(sched_set_fifo);
> > =20
> >  /*
> > + * Secondary IRQ handler has slightly lower priority than primary IRQ =
handler.
>=20
>   For tasks that should be sched_set_fifo() but require not to preempt
>   another sched_set_fifo() task.

SCHED_FIFO already means that tasks of the same priority won't preempt
each other.  I'd word it as:

For tasks that must be preemptible by a sched_set_fifo() task, such as
to simulate the behavior of a non-PREEMPT_RT system where the
sched_set_fifo() task is a hard interrupt.


-Crystal

