Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C22EB87B
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935555; cv=none; b=FKdFcDAPHwtWwZwgYxqpjp0sfgKg/GuPcdkhZsheyk6KzCbRlrM5NMaoAuaGp3IJ7Ss+2ghb5uh7RPemWH7SAR33zXUGImgp5iOGvETtf/HVYh2yg75Qi1ngFz72fByBLJJL0w+V6/1zS5S8yMtkQwXt4I5P5bvGTqZs1MNedL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935555; c=relaxed/simple;
	bh=og1lhoElF6db9WxHKkfi+3t1iLGA0iXjfHdS+QkB0Z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK8suNdCqPQrJ1vqvaSvkO6huv7xc1sWdC4u2d9y8dArXvW2mgHWcDe0tTbhH2bOJMatwHoB7/h+hJ5YCZUMFTRdpyzBu+XMqZrkqeAr+nS0XIjU9BZZs4FYLsJ2uSbCU5J2jjQ1YmWTbzk2EMqzlBIKv3OWE5VI+XILTiJo3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWgJWF/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWgJWF/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756935552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF/pjT3YTUMVt1BEngnlRmga+KCNH7T6bly4syRc1NE=;
	b=gWgJWF/WbZ3lxavtGkzb65jPSFTQQ4zaUxXth1DkIn6rqM3TiM4kHb3BGkYtBSU/O9cTl8
	il0k8WVaxbv7Ztfn2UoGHDF4PM+Bn+Poj5vvxJG0c8fHUkDUNKFRmhtiCMfDpt4xY8gFi4
	nl16f3OryoibUDgtF1RQZKfoFmcvoZM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-hKNZFjEMOGCYNt4_8AjZ1Q-1; Wed, 03 Sep 2025 17:39:09 -0400
X-MC-Unique: hKNZFjEMOGCYNt4_8AjZ1Q-1
X-Mimecast-MFC-AGG-ID: hKNZFjEMOGCYNt4_8AjZ1Q_1756935549
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32a58c3f9so7511851cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 14:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935549; x=1757540349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tF/pjT3YTUMVt1BEngnlRmga+KCNH7T6bly4syRc1NE=;
        b=fN5KxIJ6urPvQXJ0wu23uHVZc72PaBoTDk7eAlFq+H7x8rEm8VSZZU3/zrzRtnQbS3
         ntz+vM2SUInAqY1FmqvCBAET2DxQ5VjpQ4iRG8jr4opyvoIoPD6X8X2zd+zEsrF638G4
         Vb1KHI9rYlEJPqYdOTimxj9ppDu6yKGdJr6GKgYeb5OYRGNa+UgqFsmAoFf6qWafQU+J
         1aUHl0HDpjpEeKE1v9CjmL8hamhAr2a1xy2anP7rT/hEaZcCy18mC/qjS0P8EAFy90B9
         hdGyG2SrxkzRZIqyWh4ThwWaXUQoGZWAQQcrd7nDpdq3lB13FRvejru4c7ABz7PuG+NJ
         XaUw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvtmQrVVQo1zOtjwuOOV4KzYTGnrltTZpOnPT+XyBAGTd+Wz4wbK+BAkGSYMQ7aS0nHNFtgRidDa9Ep430w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy88YMIYzPg6yHo0ogCvaAIhitv075L00rAuJE0HywS1efIpf6
	rCz/2yZvXKatn1BWK1VnvGVmoqsF40u8ydBPuPZBXs1dOWeQYWw6y/4ynbJeykhFVayQuFoGi6g
	+0t7bitxCBgZtUbluJajlvOqL3vysPqQhZhIENoNOm7A84fylGajQECnHvTek9V9fSZSn
X-Gm-Gg: ASbGncvGTJRiwDrrwrRGdj3eslhwRL9JyhYVKptz2h9y4vsgogvFrlODvb5n0zi2QZ4
	6fmT8S+FHF2NCug1LSwWkpK006l3/3Muca1e9pbrL/CmWHBnSjIWIzBrkFTcWP9ntMY1fGy72Ra
	Ea6aBKuC6c8LY363kfDKmvEwi16/c38UaaDpxArixidScPnb6Y0nydkVIpmks3FYU1J4RVqiBxf
	4jABpP/Il2EYRJcAOKoPs/d39UU7H2GvPaTLMQ5rDLYhy0eKjpyx9vhp7FKR8nRqmI4dOaZVyYL
	BtDnOPP+3YO37UfM1bKSxTQfSPVD8dTMUR4c/POEM8/P7BZhkaATmKRhkWZEj29jlgwX5+M=
X-Received: by 2002:ac8:5a47:0:b0:4b3:1697:4e53 with SMTP id d75a77b69052e-4b31dc68174mr218431451cf.66.1756935549112;
        Wed, 03 Sep 2025 14:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMFz3QEIBlrasaJqBAuiIO+woAELo43+OkB+gQBfqAVDSldF8huM9fr9dqA3cdog7xNrl/xQ==
X-Received: by 2002:ac8:5a47:0:b0:4b3:1697:4e53 with SMTP id d75a77b69052e-4b31dc68174mr218431201cf.66.1756935548703;
        Wed, 03 Sep 2025 14:39:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm17501531cf.21.2025.09.03.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:39:08 -0700 (PDT)
Message-ID: <72c259c60ce28d3e815d7f243e472661932ef2ad.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,  Attila
 Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Wed, 03 Sep 2025 16:39:07 -0500
In-Reply-To: <aLf34pnRmk4ip7KS@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <aLf34pnRmk4ip7KS@wunner.de>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f42FR1iq_HrPMTICdhMeVzDuJGK9yFTTx6XNXHfbAkM_1756935549
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-09-03 at 10:10 +0200, Lukas Wunner wrote:
> On Tue, Sep 02, 2025 at 05:44:41PM -0500, Crystal Wood wrote:
> > On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threa=
ds,
>=20
> My understanding is that if request_threaded_irq() is passed both a
> non-NULL handler and a non-NULL thread_fn, the former runs in hardirq
> context and the latter in kthread context.  Even on PREEMPT_RT.
>=20
> So how can aer_irq() and aer_isr() ever both run in kthread context?
> Am I missing something?

They are both threaded.  See commit 2a1d3ab8986d1b2 ("genirq: Handle
force threading of irqs with primary and thread handler")

>=20
> > at the same FIFO priority.  This can lead to the aer_isr thread starvin=
g
> > the aer_irq thread, particularly if multi_error_valid causes a scan of
> > all devices, and multiple errors are raised during the scan.
>=20
> I'm not seeing aer_isr() waiting on a spinlock, so how can it be starved?

It's not about locks... Maybe starvation is too strong of a word since
aer_irq does eventually get to run, just too late to avert yet another
multi error that starts the whole thing over again.

-Crystal

