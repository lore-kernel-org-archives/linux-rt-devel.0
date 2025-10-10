Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99042049
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Oct 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116698; cv=none; b=gKLyUuf4KM4+JbEkx5jCXngS34jISuHOHpc44JFFCCxAQTf7iVcG8/dfhjIOhIG6Q81hQwvyiRcm2RYGPIUrPPV+iYnTawHnTx0J697zRsY3bciW8CXh4FXLScku2vNECaPJY6Jtzt2gU1wIIRDjkLRKrBnVohgvGd/EZ/7I8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116698; c=relaxed/simple;
	bh=Z8Bgg8Yh3z/S2AKEWMy72snzKqxcwIZAWYiJw1H/xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka0gyTOE7v7/8B1AwWaLGRm4IT2q5ca1Cb2Y/JYYTy+l51NpogsRIV5OI6b0IRmg29zwog1uP2IccQGTBaIHZ08gevHubsjtJ06BBhMAhLt0Diev/pPAS1Y10hvUzunPpVnKpEFyIpheU9tGfQtmZ563cWW6sVlW8MAg70/yeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo65CExJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo65CExJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so1990133a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Oct 2025 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116696; x=1760721496; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=lo65CExJKYR0s+5NmmJzG50OS4hZ8f7kVB5vZ/yX7T38PBD2RuF4qrM/B3uA2cfHbc
         HwAZ6HXc16fq+kI/fDcBpSoaeI+zX058E1h8Dr7kPVIVyrc9pwC+FHuQgkuu/B3AN0LS
         n8WRE0MN9YlmzgJdKl4Zi3H1FRUAs7F9WKC9djBmWZ7VhwXoKY6Cb6fLBpHbepn9bef0
         xms4tLENUUV2eFGeaxxKH3/XLsw2o2HILl2ampVoq3gcm4L4w/TBJobqpUPsvDEJeB4G
         JnEjmaAKVkhjv6/qhYZIVmLuWZnbZIp58GmNSeiPKATErFQ1xE+WbJyklnutToQECFqD
         w3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116696; x=1760721496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=HGyrUG3gTpTm/L29kar9RQNaSUx0nwAIvbyW0ifI+nMvmFYbfmIvjan2F5L02G0BXa
         YpvN4Cx5FFBFstg0U9Ca4FcOgLWKahiwk/H19AMioWuh/1/pM83xU/UhdR6YKn6/z59H
         4qg0NDVBHh16eCYVPUPhW4ls8loYFy4QjMohl7rCzkWqzZgysGsCCiEFHV/eB0tXrW4s
         vhGqz/K5hJkE0vxO7+aN8Y+1ctWGdkqZAdA5YUWedpSQia0ioDbHJh86hhUY2ZoyTBsr
         gLdwbY9WYSmL/aFDv7kuOVAKbOXW8p1jW6zwpjpoNAkvVEpjOPxyYnCIu5In2B73Myex
         ZCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1GLvEeOjHCa5SFFgBy5JzUdngj14TvCo/s6AbndlI48oGek1nuSiSjXQGEsEfpSnRfQdpsmSIe0nIBYgOXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTcnu4HvAzIqJaVtRvDYnW8vHssKyfl3GwE48Cua422dy9vWV2
	DN+mwuJq5yauAcuGJVUcPyKy9MO7Pp/ZY9fePS74ihwNjnRhSqf+KbAi1bHEBDrvcv3/osPcMw4
	hLlZdrqhsWXuN/Ppqa9j/ODowmV78s5o=
X-Gm-Gg: ASbGncv4epHCe7hrTv31P1IXZEYld8falM8Rvxq0hudXMU1HWeGxwcesiqhjmGcD1pd
	SJoQ1+2RdK6c8VFdMWJX6grCeh/8vz3ykZS7WidSU/c0bbUMylNAfUdXmep0St51tRiFHM+k0Jk
	kObveEOmuTNOivmWvFX2SRivtjb/1PUx2geKhFKBEL3uRC4wrv7zppdg6CUCuvLSb6MA8fYyim2
	U9zybGIfugXn76KUFtT65wZpd3eJd7qWKvYUA==
X-Google-Smtp-Source: AGHT+IH1giPZcnOv6CGAjB6Rl2QcFEzz3CPtE14GWTh10ezJZ6kvXIL6/4N3fdyqX9JAPTZlX1XtlfpaKep3fWug9Ws=
X-Received: by 2002:a17:90b:1fc4:b0:32b:d8a9:8725 with SMTP id
 98e67ed59e1d1-339edadd5b9mr23216650a91.18.1760116696201; Fri, 10 Oct 2025
 10:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com> <20251010071555.u4ubYPid@linutronix.de>
In-Reply-To: <20251010071555.u4ubYPid@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 11 Oct 2025 01:18:05 +0800
X-Gm-Features: AS18NWB9IwjfwJLLXvf_C7PSNG6WlpQ2fa-Gc_uHnrsGBHqIZb9E1EFejDVQ0N0
Message-ID: <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 10, 2025 at 09:15:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-09 15:06:50 [+0000], Guangbo Cui wrote:
> > index 91acc7b17f68..6dd231d9fccd 100644
> > --- a/drivers/pci/pcie/aer_inject.c
> > +++ b/drivers/pci/pcie/aer_inject.c
> > @@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
> >  static void __exit aer_inject_exit(void)
> >  {
> >     struct aer_error *err, *err_next;
> > -   unsigned long flags;
> >     struct pci_bus_ops *bus_ops;
> > +   LIST_HEAD(einjected_to_free);
> >
> >     misc_deregister(&aer_inject_device);
> >
> > @@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
> >             kfree(bus_ops);
> >     }
> >
> > -   spin_lock_irqsave(&inject_lock, flags);
> > -   list_for_each_entry_safe(err, err_next, &einjected, list) {
> > +   scoped_guard(raw_spinlock_irqsave, &inject_lock) {
> > +           list_splice_init(&einjected, &einjected_to_free);
> > +   }
>
> I would either convert _all_ instance of the lock usage to guard
> notation or none. But not one.


> Also I wouldn't split everything to another list just to free it later.
> I would argue here that locking in aer_inject_exit() locking is not
> required because the misc device is removed (no one can keep it open as
> it would not allow module removal) and so this is the only possible
> user.
> Therefore you can iterate over the list and free items lock less.
> This reasoning of this change needs to be part of your commit
> description. Also _why_ this becomes a problem. You do not mention this
> change at all.

Hi, Sebastian

Yeah, you're right. Once misc_deregister is called, no new user can add
err injection, and aer_inj_pci_ops was deleted by pci_bus_ops_pop below.
All places that access einjected have already been released, so freeing
einjected can be done without locking.

I will drop the lock in aer_inject_exit, and update commit msg.

Best regards,
Guangbo
