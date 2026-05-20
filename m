Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507573E6DD2
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276244; cv=none; b=Qa9juvAJZJRhwll2aUKUzqc3UzqkouVmYjrukld3nW9OEIswr+AYOPIjkQFEamrsIQK596Ih4Tilg26yCvDbyFioGYR2xpEbzVudD6NabI5ysex9n1ufYPH3a+114BZS1PofLl2chSUpHzDs3q6jucHr0eqPNjW91F8BLE87+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276244; c=relaxed/simple;
	bh=tOmKsgctFEfnm5PMXNTtW37f+M+z0xRREh2XGYifh1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OB3sybidm9ggV2IBA8f5+2V2mdh9QNhGYjKwUQpj054LQ9A0SfKaZkNTzFZMxAmM6U8OvI2N/eIViMh8QgnbkOWPHLxeQXNCbrGgdXlhLI7BsTJcNwFB5m+LJlqYvDWstsi4Mcct10FcseSRxA8rE+mMI2e/SYXCIOwoPwTuUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/7cTBnj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/7cTBnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779276242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8BoFCt0pkUBMnLRpJ4UVI49v07JwiXpXVvsRBKBXi8=;
	b=i/7cTBnjWGXFvbY/4m5SXfrpmjIf4XdagUf3o+2RQ46ZEvnM6tM3XvAPvYowAYqc4jgKkq
	v1uZYo9GLrOOSyJkf6vdktAsPO/OCQIjM+27WhxDYgAQ6mKeYuzzkj6QFvCcCrX3R8WW0O
	iETabC+//sXwWVnx4gFMKx2Ds/lv9Ko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-J6PPBFReMm-ii0ZMEBLQ7w-1; Wed,
 20 May 2026 07:23:55 -0400
X-MC-Unique: J6PPBFReMm-ii0ZMEBLQ7w-1
X-Mimecast-MFC-AGG-ID: J6PPBFReMm-ii0ZMEBLQ7w_1779276234
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AA031956095;
	Wed, 20 May 2026 11:23:53 +0000 (UTC)
Received: from localhost (unknown [10.22.64.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FBD630002E4;
	Wed, 20 May 2026 11:23:51 +0000 (UTC)
Date: Wed, 20 May 2026 08:23:49 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <ag2ZxTA9YR-okKrU@redhat.com>
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260520061920.XCqBHe0x@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: g0qJUyQN60jZml82AKAxGs_C3gTnJFAcTnkFCdbwvZ4_1779276234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 08:19:20AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-19 18:25:24 [-0400], Waiman Long wrote:
> > Commit d8bb6718c4db ("arm64: Make debug exception handlers visible from
> > RCU") introduces debug_exception_enter() and debug_exception_exit()
> > where preemption is explicitly disabled. With a PREEMPT_RT debug kernel,
> > the following bug report can happen.
> …
> 
> What kernel is this? I have backport (which is being tested) for v6.6
> and v6.12, the patches are from v6.17-rc1.

Sebastian, hardware breakpoint and watchpoint handlers still call
debug_exception_exit() and disable preemption on aarch64. That should
happen on v7.1-rc4 indeed. The suggestion was to mimic what x86_64 does
with notify_die() -> hw_breakpoint_exceptions_notify(). In ARM
hw_breakpoint_exceptions_notify() is a stub that always returns
NOTIFY_DONE.

Luis

> Sebastian
> 
---end quoted text---

