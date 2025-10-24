Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531C2FD1B9
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339612; cv=none; b=Ti77THjG2u3WbEu1TwWVP/ntrC+A61xeV0zBN8dwum/2Evm7eP/au4bmAOMo28jV9wLhdNTnlUTfQfWj+uC3+T4bjH6gm5oUVvLIk/sTI6hdmz8iOdCnkB8piLA5lJlk8FcpshkSFYZgHkmz9jdu5jcr+F5UayKiK0/FgmYkwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339612; c=relaxed/simple;
	bh=ZPgjwfZPJ4N5YUXQKwtdNaeTaiAVXpDtI0YR8v3s0pI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLkM76tOrvoe4S/41qcwjfHf4BElHjc5dZ+13FOlSl3QKFl+6YVHM0uvaz1NGSVIm86+wd6eBcWVTtAlIsW3ZhX0XEKKDNsBiU7ug3nD3gZNrIqMgTJeibjaxnYBWymjWV4ih7PBcBDyOFH413HeIg4hWmSnpTNDHesRtP2dcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPqygiJC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPqygiJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761339609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kBJfzZ98Wj4hO7jbrTSDKgQFWU3QI5hycI3xZokODY=;
	b=XPqygiJCj4Sh+cQG6+Q72GlMiWG8sTPUU9n11IScWS6cl166Q07vyzMC/W2hwSAX78uII2
	EmDHse6Z/cAvCcvVQAm0iixl/n4IjJe7EGS5kjq4/qSsdzRdQCDqGEHvVcooBsaUKT2/7U
	MjN37JGee7Vj3S4E2A8NVoOuO3nyQwM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385--bfa3ZfWN2qbJxurafHo9A-1; Fri, 24 Oct 2025 17:00:06 -0400
X-MC-Unique: -bfa3ZfWN2qbJxurafHo9A-1
X-Mimecast-MFC-AGG-ID: -bfa3ZfWN2qbJxurafHo9A_1761339606
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a387d01bso92275821cf.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339606; x=1761944406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kBJfzZ98Wj4hO7jbrTSDKgQFWU3QI5hycI3xZokODY=;
        b=HpmdR3xDR6dSyWA/ad91Krym1Td0Boyx+yjn9x0UrsPuBm5eCks0AScC8bXOh61kUS
         q/g46qzhxQrcesYe/IYgb65BZKAG45MZVjg4vpuw6oK55bhkF2i2zYdtDGZzjAFp/WxP
         029xbOMTOf0RSfetv5a3ugNh3iJdiFRU7pG9WrJeRZ6Txvc1aWlzL7hjjXGo2asSvYAd
         4iyI9U7mPKVjtkrQ/UFTcRxUKLdK+ZVV2AW4k30tO0Mq8JlOiY6BrpTCl3FsV06uOviU
         OTElVMjGSfB9i0ZLR7bFC2o+2wzLDsWTrSYngfcOAHYq0wCNdu5y5kg01CDuv9Pr0C02
         OtoA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Jva2iLYnD08ul4FvIITk8Bcpg7yqjKMEAge5gs5t5h/GEUQX2ruGf6D7OODaLwrMhAsLDhF72EwIKwWSZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysfOTkRqYMhpWXgujg1W0HiKuvvwGoWddnLJ41FeA2ILIsTjAe
	80AvvQAKYa4n0X32BBsgZmCm/I6FL9Tg/6dYcyaYB1k9sNj+3qj0z3o5hjT1xQRC+giIivTizeK
	Dh0lewiYMN+UKGJyVsWeWp7KUUA/ax9kgVrd5EP04fVIM7/1f+5V+eQAeadmARMlFSlc2
X-Gm-Gg: ASbGncu9IesIcS37a25wC3Nrh/77f+jCkZxPvhbe7+CPB7Z40yg88YnEv5WFaIT73hr
	WGgbKk9FGbMo5qvGQSpiqPJ8aP8ekWdf4gYGm8YayYLxVDxqpx3vvkxIzAhScfBZhYuo4noz0YK
	rXo5FWhAW5LOPLjFHf3CG/WWUKZmLvCj9XWAX84ddUiT6CPIfGQYNsETMb1izUVJj55hAFA87Wu
	jp1U1HbzV2P85hXuMiYoH0EMdi2fDb/KvBpZQ2c/7SKjUeOI8cfav3063ys4jKKeoC+ZLr4utPV
	Mi/q7b98h4XqtZXpQodzM5j5Qb9BAZNHuo3of7tDFKNtO/gTEgvH1lwV2qqwfixuVoA/xQxIq+j
	l+yRgSSSKx7PGFOROW2ddzyapRxKPMx4=
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr382356371cf.21.1761339605824;
        Fri, 24 Oct 2025 14:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLNVhaK81BrJnKYK1JoNVu0V1nl9SpXqeB0PT9Cm45xU7eGhzyqHOxksmutDw6Htl+hrp3CQ==
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr382356031cf.21.1761339605381;
        Fri, 24 Oct 2025 14:00:05 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37fa7b9sm1065531cf.17.2025.10.24.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:00:04 -0700 (PDT)
Message-ID: <de1ec7fcc1711e3062cc321ab55552339630de30.camel@redhat.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot	 <vincent.guittot@linaro.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Attila Fazekas	 <afazekas@redhat.com>,
 linux-pci@vger.kernel.org, 	linux-rt-devel@lists.linux.dev, Bjorn Helgaas
 <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 OHalloran <oohall@gmail.com>
Date: Fri, 24 Oct 2025 16:00:02 -0500
In-Reply-To: <20251024133332.wSQOgUZb@linutronix.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
	 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
	 <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
	 <20251024133332.wSQOgUZb@linutronix.de>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zyTdRhghFOrTnfhrmL9f_q7Q3hUFAKT1NIkO91F7bB0_1761339606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-24 at 15:33 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-03 13:25:53 [-0500], Crystal Wood wrote:
> > On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> > > On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > > > I obviously understand that the proposed change squashs the whole c=
lass
> > > > of similar (not yet detected) issues, but that made me look at that
> > > > particular instance nevertheless.
> > > >=20
> > > > All aer_irq() does is reading two PCI config words, writing one and=
 then
> > > > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. =
So
> > > > arguably this AER problem can be nicely solved by the below one-lin=
er,
> > > > no?
> > >=20
> > > The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> > > proposed:
> > >=20
> > > https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
> >=20
> > So, is the plan to apply the original patch then?
>=20
> Did we settle on something?
> I wasn't sure if you can mix IRQF_NO_THREAD with IRQF_ONESHOT for shared
> handlers. If that is a thing, we Crystal's original would do it.

Do you mean mixing IRQF_NO_THREAD on this irq (which should eliminate
the forced IRQF_ONESHOT) with another shared irq that still has
IRQF_ONESHOT?

I suspect it was a non-issue because of IRQCHIP_ONESHOT_SAFE disabling
the forced oneshot (the other irq was pciehp).  Given that these are
pcie-specific, do they ever get used without MSI (which sets
IRQCHIP_ONESHOT_SAFE)[1]?

The issue seems to be that the type of oneshot we want for forced
threading (unmask after the first user-supplied handler) is different
from what we want for explicit IRQF_ONESHOT (unmask after the last
user-supplied handler).  If we separated those, then the semantics
would better match non-RT, and we'd only need to care about mixing
when it comes to explicit IRQF_NOSHOT.

> Then there is the question if we want to go the "class" problem to
> ensure that one handler can preempt the other.  And maybe I should
> clean up few ones tglx pointed out that provide a primary handler for
> no reason=E2=80=A6

Either way works for me, as long as we pick at least one :-)

-Crystal

[1] I realize that the answer to "has any hardware designer ever
done this weird and bad thing?" is usually yes. :-P

