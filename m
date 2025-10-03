Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5672DCF4C
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515961; cv=none; b=QpA956+ArFkBCdJI2W/mnZGiMta/BqnvFVDv2vbQgXu2m2R/sQ/o1upiqc8SXoaOWHDJJS2xf9o3Jsrgt67NtscVj4bPMUoo0ZZDyKDBiVMggaa9wEhsragz289jfDPK6gA7GhkuIu0lMwrXyJRZVVQBCZc/NBn4bUTttN6Vp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515961; c=relaxed/simple;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akvofxw2wKAOQwuTJoVoLaFKJbb++O0EI+yrhu4i0UPQW9tNgEwE8rVQ3h4Zb+266mRncD2BjYpiRn2luarYAr0UYAZZbZSzSm6ci4wcidbkILFEoSRwLQHrClWpGCCkB+SW8nKQrQ7x/rGjekmhHPmNqndB4Fx2VJxCSS3P0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqLyf++K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqLyf++K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759515959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	b=BqLyf++KVkPmaFWBB1FXmVsvdA4XcZKAdmr+Nh6Bn+oPtv96BWPgw+bvBD35sBJkGxxnzH
	nG3XUid6FGK/boc5YN9u8FOU4bqBBOwo6TG5/kEPCyQ6XwcVar9Fw7g/64Sndps+BOPo4Q
	DObkUUpjhuirtQU1HONa11u0lcZdbP4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-kjcVT7KPMhSAhQxYNo2hxQ-1; Fri, 03 Oct 2025 14:25:56 -0400
X-MC-Unique: kjcVT7KPMhSAhQxYNo2hxQ-1
X-Mimecast-MFC-AGG-ID: kjcVT7KPMhSAhQxYNo2hxQ_1759515955
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dfe8dafd18so106687121cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Oct 2025 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515955; x=1760120755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
        b=QtmWXrgOM6Jj2d6ET4UC5G6pmekQdZu02FjbMA2fEUIHCqhEb400cSKF7q7AUPJfFR
         t4kv/R0k/1fTvwIYc3YNOyfwtZj5UErc6D2Gr0iuWSEYHvqTGDp8NLbjob22AwmF78JS
         /AbemmyMKrK4rL1NA8i7w1ykI8LzMbhq0tbdisKj7/8t2ogRuAihNB8nHgw6bQ8k6Flq
         9ZGTUDzZ9GmhVuL+yuMSbADXZ7Cicdn8pM9YVAIKsvmNVwxAhqAN2O1SGiIlVgkxU94+
         K31A8ivwcUWv1Nwr7B+/LzHlLEqq+5gmdTS9lu36eoUoy6gSiiuOFL6/noUyq7VLi8Td
         G/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMxFvFwIvcPqXHj4Mc+d9Y8QeyIbFqm1xL19XMnJJuddDYIFYVwC4J7i3MbsVfbd/3oQy10UNnNDZrtXvIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEGI9HCzaiqAB9QkRhyXTXctqcOijT+OsqpVPt6NR8xcmgKulk
	jTYqG2MTb+If59V4oLyc3ROgVMF9DRl7OHqHAjr85088WTr+cjpTJFs6/O0iP3t2q2P6WHPIMsX
	MGON0NwMGHUAuzBk9S6HJi6AApn35AUOypt2Tt3+nQwi4dUvREvt9E8vZWLAF1LBh1u3G
X-Gm-Gg: ASbGncuFDFu6rkbcxHT1nzfDiVyEcgkQCBfkFZ0Po5b3VT98Td4Y/HxfI2vxjSDqcu0
	AYYQ2Whnb6ze+aePda9NaSDe1Dn9vanIYNGfUUBU2DX2GbDJmnRKM9pjdetYcf98zG2FTxMdfYM
	u2ti4kSj0anuHZ1pftTKSor1NEa2n6kxRAD05MdmRDz3hUmUI9/dWFr26NhRSiKUHFWUpqhkp9P
	NrYvgkEd2+NHD5/5Vk5cwOoG1v84EWLp2mzgu8IXlf7EAyWTrIKLOARGagx/27CzGUHBHxDGa6D
	L+mb5829+4zZ2NGfAZgVQpfLC4VSC8zoe81RZziz0oBZv4+/o9fueeucn7bZwBcWyp3GQE83PA=
	=
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51800441cf.75.1759515955471;
        Fri, 03 Oct 2025 11:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl6MbKs3Xb6exRfHKs8R/8W88faZKEv/f6HSCYFxtPk4/rUynv2mK5zOAipf0zbQgK3MTWtQ==
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51799931cf.75.1759515954967;
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf52afcsm44134596d6.46.2025.10.03.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Message-ID: <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>, Ben
 Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, 	linux-kernel@vger.kernel.org, Attila
 Fazekas <afazekas@redhat.com>, 	linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Bjorn Helgaas	 <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Date: Fri, 03 Oct 2025 13:25:53 -0500
In-Reply-To: <aM_5uXlknW286cfg@wunner.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
	 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zFAph7Rh5bGwWiqZSQsmp6773fVrNYb8SHp1EsLM8nQ_1759515955
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > I obviously understand that the proposed change squashs the whole class
> > of similar (not yet detected) issues, but that made me look at that
> > particular instance nevertheless.
> >=20
> > All aer_irq() does is reading two PCI config words, writing one and the=
n
> > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
> > arguably this AER problem can be nicely solved by the below one-liner,
> > no?
>=20
> The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> proposed:
>=20
> https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/

So, is the plan to apply the original patch then?


Thanks,
Crystal

