Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5261F4620
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961323; cv=none; b=e55qOATeeNDru3S6/syngGy49KMI4zvxo8Q+S6AAUjLit0XSsIEwYD8yR8IKyyoGyT4j80r5OjIDMRSPI6LzOvsuAxYr6EjY9YGyuq7khBBQlV5FKMJ5BN3hMk7eyZM0Gq9VhhEIrbZcKWkFCGhZ8Gk6DT0i40tKn+NaheWgSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961323; c=relaxed/simple;
	bh=MFg1OSkdrtj8BbiG24LBD7HCica9AafyjqlwW3tvmyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yagz1OoJ2rMlWc37bP5B4bKdxP+vPKDUMKucOjllamN+EDKoDjx8wDyy0QXfkLqBgLf7Gfl9xDQGiQsGNLxqXXK1lgLcEPGnNHVAXM5zPyqEZFwDqmdsCjYFNBmiQtyx6+ndkVitMvEcoMbUAkFgslbYuLB9Mjj/JMOvrDusM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkA87tdL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkA87tdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741961320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zx/Aek1+KGFt8DlfzOfA/fn4QPcntf53i1PGCHelXo=;
	b=bkA87tdLj2/2jh3bN/tU8RSyETy3LYpE0WZWJhPebb44RO8B1DOC6TukysNt6b8q8anI7l
	WHr2zLYvLQMKBWPGR3WM0tSUPbhKuCHiiKrOhVeVXgmtsHdq9pRxxK/QwoMF/4GgVhaLX3
	GOjrhZF6Bn+VixPDVduZfagVXHFgYDc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-_eEUYm2TMO-sy07buha9gQ-1; Fri, 14 Mar 2025 10:08:39 -0400
X-MC-Unique: _eEUYm2TMO-sy07buha9gQ-1
X-Mimecast-MFC-AGG-ID: _eEUYm2TMO-sy07buha9gQ_1741961318
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so3807031a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 07:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961318; x=1742566118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zx/Aek1+KGFt8DlfzOfA/fn4QPcntf53i1PGCHelXo=;
        b=T/2yxrNnyMId+5H9nonWwFQO0gVxU/VkRwnACukFOt7hUwXdYLzWqTok6Kv1n1uriE
         z0uSe5tTYX51GAe9QOr6ec1ZKZMfRyhu/Gi49f7JBonUbBPwsU/8PcRnqIv39CB/nLp9
         U+URmQslNQwqjADhDQu08/4dsYlvfivHIG+RrXJddl0zc3qwCSQ2Xno8JPessHWFtqmD
         TBWNqDksK9we2FwVQXWQU04pYC1AVrNt9j9JGK1UpoX+/0KUZFyLdn+vkVmIy0zJ3pJv
         MYLhhw4E5yC+03Ri3FEowJeO2vvUvGDUQjPH5QyTa/V/M97XYTNUEg26bbmwmZheYipd
         tg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrxSOeAqEZ4SwE0PbHC0UAvAFYRupE7ldjw71B7RGGy3/TJo8ysI+u+6hcicwQ9n5/WZ9i5Q46TsaxufdOcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXr0Uckux+61ffP0A4SdSIt2hlBJ6KSNRk4tzx8lndSmQ4aI6b
	12RD0P3Iax5UD4Qj4Ff4ayk7R95LUhnKsRhL3R9O9Aq4YKL7NlmvBfzEo96LZ3UoeUsQh1pPwr2
	DtGBY6TdJL2ogzF5921ML7GNO1aFCxw3UCmAH4+kY5AYMocBSG7BxoG9/yZKRsp+tkn9Squ9rUX
	Lk/TmIbyplgfp6W3gj6338Xbqiorg9EkhEJo0qcJA=
X-Gm-Gg: ASbGncvwY2JY9xig2FTxdfxs6JqqQ9kzi68JznGLdD1Em8VdypseKZTUQMXO1giT/j6
	rLisPWJozlxmkcyNqazeVUorxEpbN0VJxBd4HM5uOtow5zwOYale9eDL7lN5ljiud3gWqIOch
X-Received: by 2002:a17:90b:5107:b0:2ff:6608:78d5 with SMTP id 98e67ed59e1d1-30151ca087dmr3966445a91.15.1741961317976;
        Fri, 14 Mar 2025 07:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVtNvVcY9lyR2ocSnQDy0HfB7oZreivvccNnRN94HdRlnCbSLicb2258UoPAF1JoMK0wn5FlkNwiIZ7a3ENA=
X-Received: by 2002:a17:90b:5107:b0:2ff:6608:78d5 with SMTP id
 98e67ed59e1d1-30151ca087dmr3966397a91.15.1741961317634; Fri, 14 Mar 2025
 07:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250206115914.VfzGTwD8@linutronix.de> <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de> <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de> <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de> <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
 <20250220113857.ZGo_j1eC@linutronix.de> <CAAq0SUkMXDaSvDRELYQn9+Pk-kBjx2BWc7ucme54XPXD97_kkg@mail.gmail.com>
 <20250314131645.1S4dYLPv@linutronix.de>
In-Reply-To: <20250314131645.1S4dYLPv@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 14 Mar 2025 11:08:26 -0300
X-Gm-Features: AQ5f1Jr56_k2E0dRR8oViHHGo3_JU_wuZI8KHBJk4g646LE-LLAE96AYrxhUtZk
Message-ID: <CAAq0SUmgH0jsELrJETaE2TrNUJiV9S8By-n5rUujDtQxYWbnFQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, 
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfqPS1J69JPDH3DKeJqBtwyGMdhzeXcxUKswHig1DCI_1741961318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:16=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-03-14 09:12:20 [-0300], Wander Lairson Costa wrote:
> > On Thu, Feb 20, 2025 at 8:39=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2025-02-20 08:35:17 [-0300], Wander Lairson Costa wrote:
> > > > > You confirmed that it works, right?
> > > > >
> > > >
> > > > Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, ye=
s.
> > >
> > > I mean just request_threaded_irq() as suggested in
> > >         https://lore.kernel.org/all/20250206115914.VfzGTwD8@linutroni=
x.de/
> > >
> >
> > I forgot to answer, sorry. The answer is yes.
>
> Are you going to post this a patch or want me doing it?
>

Please don't hesitate to post it, you are the true author and deserve
the credit.

> Sebastian
>

