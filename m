Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813827FD4B
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Sep 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017668; cv=none; b=mJXaZfkPLU3mVDXs7yYR+JF+RzPj0Zt2yTAfPW1FEK0c6rZ7b0ZJQ1GWiu4BUBC/hJTWl/mFwkB/0UDEZwYwWnGq20ShmLPO9mfaLlWuWSCcAGRKyVw//LBOjAjlOvL3yCI5wYfcMqBlhKV32AMXPfbht46J/0hP8iSjKEyu97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017668; c=relaxed/simple;
	bh=N8eCdZM0e1KFvaZy3m8dOMj25wjxj/KnbnQWuZFbgOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgSvN1pzhjoqp1inYLaS9NBPE1H2vBTavi3fvvOE9YZjtotp/eZd/UFERx1SzevQIQ9jLqRwcH36T0TM4wfc7VV+JkJihUpNrVKtMK++6L8f4rPsTRKTB/gd5vaTwIuGbuscHZn42BzK3Tm2HvK1ipk2h0b/Uo1FhxP9aS/q1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb+Sl9O4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb+Sl9O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757017664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pln8+B9jQ8rncziQu/O7xMtur9zJEybxx7bro4vdYPY=;
	b=Wb+Sl9O4pxfTxbyOlICIafFFfQ2c52M0xvOY7/bf4Xo0cgwkWeXwfBEd5eBPuGaKixNLDU
	nuDrba0iU5lppkwmCl5f5w8ez4wfYxAz/6a0PUhlcggPBwU4j/P4yR1uOJPRBBFv4eHmet
	nPn2zOdF/wEAmCQ+oY4jc04nRVMn+R8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-y9W0_lePMNywpMooLz1EHw-1; Thu, 04 Sep 2025 16:27:43 -0400
X-MC-Unique: y9W0_lePMNywpMooLz1EHw-1
X-Mimecast-MFC-AGG-ID: y9W0_lePMNywpMooLz1EHw_1757017663
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-728f554de59so25501046d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 04 Sep 2025 13:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017663; x=1757622463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZ1ZQZXiD/ZO6OVnKe6uaA+6mzR9P3Qvw3jlDLaXgXU=;
        b=fw8lB9EoL6vDrgcCGTUQeN1XGXSyHowpBN9wkivTxiyGgsVSRgKdDwqoX2xyv6aMGR
         1AJ4Q9ZHKejgwzy7ZF/FXcr2I0lP5gAKMxy2zaeSDilj6UB4fDbpODztuExoW/wpFiB+
         wr9EfOawa7TWYScRKwWC/oYudKgqYaXXs5G/ZY7j4tmQA8VSCiUh4TSOloYET5fsL1D9
         J74FENd6pyd8atkWooz29pkxdaYaATcgtoGhJdDKslCpSupn0ACiRTOfDPlytPFop7Rj
         LYb4hilK7ck81QywXLD6kec9RGjsHndXdwSGran+pSQbtt94XGjrbDpJ1XSZVUP7S7uj
         AQUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjiPmuzJpH7kVTTFhIO1V7TWhKeAeaqGj2Qu5OoTBvlZjLDV42orgA7Cu62TUL7m1IoyLpnZLGpbKQV49bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8nc1XNxJDcAtqMCcbB6RpUMiAr+xHS/WyTPgLuEemZOEfWDE6
	AolcGRWrUtYZMA/VxxZh7ZxR7gs4LARy7CYH88ubOqs43zP3oU8xb3psQxLeSc/SW2moNKGt+4f
	3LnJB2hh1Vs4oU/284bEyr1rAcAF3rT6oBOEbfMBimOzXdLf+y2iPg+OV2nkXziDI9LJN
X-Gm-Gg: ASbGncv9aX/pvPbw1FkQ/XlSuTk4HDjDKnv3Dc1sORGdw5lqzhnkvvCAyAiHWb1TqMa
	Ho4Vp+aVkXzucHPEvfxXCqLESMBOvetF3WMfMKBiVq7vF8oOOlPi+K0jAUwca3dYOVmP3UOHnHd
	lLPJqjpm6B+Hz5helm4wU+Av4dJZSp9aAu5RDTA1x0ln8RhVLAIahf5O4SIwkHQlH3IUPYTm6OC
	4kHHD0RShTzftvWAGpYRDBxDzT9DeuHHch0OV43FZ33XKEJP6kVUFF/rtQAtR9KfMnMhEt9+Fvl
	NW4o3dC7YBHH3QVgKh1OO2f+mHXCXgIMNxgEirfy1ZNUvsHIRNhqI86huFuTc7btvscbrPw=
X-Received: by 2002:ad4:5aad:0:b0:726:1de2:2806 with SMTP id 6a1803df08f44-7261de22ebfmr85045896d6.60.1757017662763;
        Thu, 04 Sep 2025 13:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SPpqxVrAbA38PLE0lpRBaYsie8jxvbY2zZCX+I3O32JAnLmwjhFOblpyGk+BfBfntAn/UA==
X-Received: by 2002:ad4:5aad:0:b0:726:1de2:2806 with SMTP id 6a1803df08f44-7261de22ebfmr85045526d6.60.1757017662137;
        Thu, 04 Sep 2025 13:27:42 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cbc78sm52569886d6.23.2025.09.04.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:27:41 -0700 (PDT)
Message-ID: <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Clark
 Williams	 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Attila Fazekas	 <afazekas@redhat.com>, linux-pci@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Thu, 04 Sep 2025 15:27:40 -0500
In-Reply-To: <aLmKlVaKSBurRys1@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <20250904073024.YsLeZqK_@linutronix.de> <aLmKlVaKSBurRys1@wunner.de>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iE4J0naTnFLHYNOzxp4IJP1i_pElUlXGEcgsQsbrdcI_1757017663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-09-04 at 14:48 +0200, Lukas Wunner wrote:
> On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote=
:
> > On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> > > On PREEMPT_RT, currently both aer_irq and aer_isr run in separate thr=
eads,
> > > at the same FIFO priority.  This can lead to the aer_isr thread starv=
ing
> > > the aer_irq thread, particularly if multi_error_valid causes a scan o=
f
> > > all devices, and multiple errors are raised during the scan.
> > >=20
> > > On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr,=
 these
> > > errors can be queued as single-error events as they happen.  But if a=
er_irq
> > > can't run until aer_isr finishes, by that time the multi event bit wi=
ll be
> > > set again, causing a new scan and an infinite loop.
> >=20
> > So if aer_irq is too slow we get new "work" pilled up? Is it because
> > there is a timing constrains how long until the error needs to be
> > acknowledged?

The error needs to be cleared before the next error happens, or else
the hardware will set the "Multiple ERR_COR Received" bit.  If that bit
is set, then aer_isr can't rely on the error source ID register, so it
scans through all devices looking for errors -- and for some reason, on
this system, accessing the error registers (or any config space above
0x400, even though there are capabilities located there) generates an
Unsupported Request Error (but returns valid data).

Since this happens more than once, without aer_irq preempting, it
causes another multi error and we get stuck in a loop.

> Since v6.16, AER supports rate limiting.  It's unclear which
> kernel version Crystal is using, but if it's older than v6.16,
> it may be worth retrying with a newer release to see if that
> solves the problem.

The problem shows in top-of-tree.  The messages are ratelimited, but
the problem isn't from the messages.  It still does the scan.

> > Another way would be to let the secondary handler run at a slightly low=
er
> > priority than the primary handler. In this case making the primary
> > non-threaded should not cause any harm.
>=20
> Why isn't the secondary handler always assigned a lower priority
> by default?  I think a lot of drivers are built on the assumption
> that the primary handler is scheduled sooner than the secondary
> handler.

That also works, and I agree it's more intuitive.

> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> > >  =09set_service_data(dev, rpc);
> > > =20
> > >  =09status =3D devm_request_threaded_irq(device, dev->irq, aer_irq, a=
er_isr,
> > > -=09=09=09=09=09   IRQF_SHARED, "aerdrv", dev);
> > > +=09=09=09=09=09   IRQF_NO_THREAD | IRQF_SHARED,
> > > +=09=09=09=09=09   "aerdrv", dev);
> >=20
> > I'm not sure if this works with IRQF_SHARED. Your primary handler is
> > IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> > forced-threaded will have IRQF_SHARED + IRQF_ONESHOT.=20
> > If the core does not complain, all good. Worst case might be the shared
> > ONESHOT lets your primary handler starve. It would be nice if you could
> > check if you have shared handler here (I have no aer I three boxes I
> > checked).
>=20
> Yes, interrupt sharing can happen if the Root Port uses legacy INTx
> interrupts.  In that case other port services such as hotplug,
> bandwidth control, PME or DPC may use the same interrupt.

It's shared, but with another explicitly threaded interrupt.
This is with the patch applied:
root         778  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
aerdrv]
root         779  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
pciehp]
root         780  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
s-pciehp]

If it were shared with a oneshot irq (forced or otherwise) wouldn't
that have already been a mismatch?

-Crystal

