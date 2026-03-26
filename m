Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBD3CB2EF
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Mar 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549457; cv=none; b=eWZGZFtIhn7olxRuBA45DtUzS0CKcAXmwQOY/meXLFIlnwayblvy6WsZEKRj/GF3YVOJ1J5cJ5FcupuGCiZYpQzBZZUhmzy78mByUin+YkTs7MfxI9EtFB4yrOWQZS5vMZzRACW/b+dEZrL4hmXsGRYgaZBHHQ4201P/QmO/EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549457; c=relaxed/simple;
	bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeM6jtX2S6bub+wv01hw/50pvLMT17nF/4G8QZNj0NtYN90z104L6uT4taBn8mxZq1nfClhe3+zXO3vFPy6rTOTs85w5ojMWPu0wuzMc/oXRLSxbb4Rs6LSQcpLvechDHhgRqn+QhZ+kxD1mOirPDtisVwgrzrksiO6GbY/ZxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct3GrHWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct3GrHWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
	b=ct3GrHWgTbREyH5bP45z0lIkfyo41MCcJ/GNlRacLRtFptbNyD9XTSCQJbpYB521NlaKLG
	Rx1qtrX+swWHOZ6zccMZduwdkG6Lszu5b76llOjHvlD9WRteKxHmqJ34WR7re63Lh6kxPm
	2xCkUncnkOu+cRM87LEaos3iPPiNMkA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-SK6U9-HmONy6PXoN8FhWVg-1; Thu, 26 Mar 2026 14:24:12 -0400
X-MC-Unique: SK6U9-HmONy6PXoN8FhWVg-1
X-Mimecast-MFC-AGG-ID: SK6U9-HmONy6PXoN8FhWVg_1774549451
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b86de58d9so1045762f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Mar 2026 11:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549451; x=1775154251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
        b=qKdZCoyI5NJS4J00yGCYgHZ/+T8MfIPXypBzlx+2V2et1//flZKotg+DWe5a0ccEZ0
         cjRKZ3WYIsCFhreGbQM70tEq6nQDXTuycwMzifzRsIQPL3up9JIvRuOYLL08LVv/IsU4
         g41Fxl0sBhICsuXXdZF8HrEq7oPrMr4yBBMqpi0X5+vPUZJMp0pX/yad8YIPbn4h2VnO
         y2AweevMHb0LgpAl8sqpQNMxV4WXqRZJQZkcJFCkWW5GBOkqFnX2f7vcYSOW05iN3K2/
         pAI6OP6FL03ZckI1yJEG9UpW/pF67kRgpExDXxMRj/Ts/nG4i5eGbtg6s6+B5ceXM3IY
         S7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWAwyzGuQEYSfnQ4jlDdcAMhQcVSRF4bIlWLYYIBeomDXaG8tHdZxJtvD2/uyRaiPGrUWClpub1sO+klW5x5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk5ZXL07tVsLX68DXaBMmdbtM0iylXjVdiRGF6eIZSIqBLp6qi
	2jEKRanXXkpjRB9WWhuCGnWT9Tj078xdCGG1I05BrzC6rt+6IHTUq/fpWCQSftx8JGWxm9ZBV5A
	8eGWjLCbS7ATZYJfLkKuaFB/0O/Ia5WSmaWj1aq+pGTgkaxy+j5Iwsv2UXRRLxqLdSAiToQ2Pvt
	H2exRJME5d2C7oLI8iujooesa+/b2AG4AjYr6n9YVneZ8=
X-Gm-Gg: ATEYQzwYxkDMKn5tttKRHtWGNPIXFdlXgs5DtmXtq0DhfUOW+qAWJpr3ziSAz1Qy8hq
	BwAsz58E7NcNK/LScEOIFEyptAiOqfZR1eDzKKkSeGbDMGk1SPfP7VExA3BVMM3A5Ow0is2WFmy
	pKZNNdrQo36EooYsErxt8wsYwcfHrWeBzuYQH8/7yOb6QAqN8dXarC3Aqnl+Atd4r1WAs3B1myy
	z1ktHuCi5xfzYUkBqCGnuZHNQ5iWum9U6p/zHZJhhQ3P/oHXkI4I4r4LaY0EcecMFKIXoLPRNtn
	11L5
X-Received: by 2002:a05:6000:4285:b0:43b:45a0:9df8 with SMTP id ffacd0b85a97d-43b88a0fc0bmr14534066f8f.35.1774549451015;
        Thu, 26 Mar 2026 11:24:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4285:b0:43b:45a0:9df8 with SMTP id
 ffacd0b85a97d-43b88a0fc0bmr14534017f8f.35.1774549450552; Thu, 26 Mar 2026
 11:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41> <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41> <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
 <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
In-Reply-To: <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Mar 2026 19:23:58 +0100
X-Gm-Features: AQROBzAmyn1P9pR-79R4cWceEXwBMD15hAO83tLul9jg4y2-Qgpzo_wGmuGmSBM
Message-ID: <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MUKWigcW2ZWawRBl_PbjhGW-fhGR6C1ZZlRTHiwmBiw_1774549451
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 25 mar 2026, 06:19 shaikh kamaluddin
<shaikhkamal2012@gmail.com> ha scritto:
>
> 1. Added oom_enter callback to struct mmu_notifier_ops in include/linux/m=
mu_notifier.h
> 2. Implemented __mmu_notifier_oom_enter() in mm/mmu_notifier.c to invoke =
registered callbacks
> 3. Called mmu_notifier_oom_enter(mm) from __oom_kill_process in mm/oom_ki=
ll.c before any invalidations
> 4. As per your suggestion, move existing kvm_destroy_vm() logic that alre=
ady handles unbalanced invalidation to the new helper function kvm_mmu_noti=
fier_detach() and invoke it from the kvm_destroy_vm()

This is not fully clear to me... It could be caused by a recursive
locking, or also a false positive. It's hard to say without seeing the
full backtrace, but seeing "lock(srcu)" is suspicious.

I wouldn't have expected deferral to be necessary; and it seems to me
that, if you defer removal to some time after the OOM reaper starts,
you'd have the same problem as before with sleeping spinlocks.

Can you post the original patch without deferral?

Paolo

>
> Key Design Decision:
> ------------------------------
> Implementation point no 4, while testing, Issue I was encountering is a r=
ecursive locking problem with the srcu lock, which is being acquired twice =
in the same context. This happens during the __mmu_notifier_oom_enter() and=
 __synchronize_srcu() calls, leading to a potential deadlock.
> Please find below log snippet while launching the Guest VM

