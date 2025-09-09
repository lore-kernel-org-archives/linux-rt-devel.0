Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52132CF83
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420558; cv=none; b=Qqn6aP3rnBwXFJVwxPH3ZSvycksevQUyUVAedaBX0rGFi1ZS1+BYqkwIvSNRk+jPBP9p/MO4RkWGEil68wvGISR6gpyUEX8Quo2RJSDbOw5xN4qoirO+37YjgcB4nEwrnTo4pTQH8l8XXDYPpHwo+pndsx2Y438pQD04fgUrbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420558; c=relaxed/simple;
	bh=LEoIvUCZjmFRMqhlnS4k2kBDTkILS00++ijrZc+ysvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9VlLE7Sy1h90LEQzsUxSFjqmhOkNPx4EGlWpx229TPdvjbpm5vzV/Rjm06/kWv/dn0q69YWXE4nF1rAOsSJZLQEzKFOI0f5NKLYhUkkJZcVSl9zvuAUfwrh2ZuCbvNP6CPp0EQwVOfKH/FV0KUBcRCzke76rr4eDFpMiF1c0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EonEZDih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EonEZDih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757420555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wu8ICdLYs/cndqwtdIolQkmc1MMS+eRGXoe/OnyOz0=;
	b=EonEZDihrxaOONDlzVdwOHpf1lk5ZmdpzNbUQXT31E7JVFsCkzhwdykFFe9Ov1PBtAi/JW
	T/hsFz7cCKS9rgFhgSo2dV5NX3URg1uC1vYukmTYLPF0A/jbtWIRSjldD8IHDeAFNnSpSN
	ZRBt0lNesVvwgbD6gDtvmtqf3fyfSOk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-nkP3eaCROTuggPxvVA6xHg-1; Tue,
 09 Sep 2025 08:22:32 -0400
X-MC-Unique: nkP3eaCROTuggPxvVA6xHg-1
X-Mimecast-MFC-AGG-ID: nkP3eaCROTuggPxvVA6xHg_1757420551
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 334F2180034D;
	Tue,  9 Sep 2025 12:22:31 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.76])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA3FB19560A2;
	Tue,  9 Sep 2025 12:22:28 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
  libc-alpha@sourceware.org,  John Ogness <john.ogness@linutronix.de>,
  linux-rt-devel@lists.linux.dev,  Thomas Gleixner <tglx@linutronix.de>,
  Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
In-Reply-To: <20250909073226.0qoHYZMo@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Tue, 9 Sep 2025 09:32:26 +0200")
References: <20250908163329.Qq79ujq_@linutronix.de>
	<4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
	<20250909073226.0qoHYZMo@linutronix.de>
Date: Tue, 09 Sep 2025 14:22:26 +0200
Message-ID: <lhubjnjbyt9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MfXzetRfjlsgacZyzy1HHROxEosltFMdwls6XvjAYys_1757420551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

* Sebastian Andrzej Siewior:

> On 2025-09-08 14:46:12 [-0300], Adhemerval Zanella Netto wrote:
>> > This change expects that PI-FUTEX is supported by the kernel. This is
>> > the case since a long time but it is possible to disable the FUTEX
>> > subsystem or the FUTEX_PI part of it while building the kernel.
>> > Is it okay to assume that PI-FUTEX is available or should there be a
>> > check somewhere during startup and in case of -ENOSYS a fallback to
>> > current implementation?
>>=20
>> We removed the __ASSUME_FUTEX_LOCK_PI (f5c77f78ec03363d5e550c4996deb75ee=
3f2e32a)
>> in favor or always check for PI support at runtime during pthread_mutex_=
init
>> (prio_inherit_missing).
>>=20
>> Since the kernel still might return ENOSYS for FUTEX_PI I think we shoul=
d
>> keep probing its support as runtime.
>
> Okay. Since that one is static, I guess I would have to make my own
> check in pthread_cond.
>
> But=E2=80=A6 Now that I look at it again. The kernel has this FUTEX_PI op=
tion
> which depends on RT_MUTEXES. But RT_MUTEXES has no off switch so it must
> always be selected once FUTEX itself is enabled. The I2C subsystem
> selects RT_MUTEXES and I don't think there is a config without PI-FUTEX
> considering this.
> We _used_ to have runtime detection for PI-FUTEX support because not all
> architectures provided a cmpxchg function for futex. This is gone and
> all architectures as of v5.17 provide it. That would be commit
>    3297481d688a5 ("futex: Remove futex_cmpxchg detection")
>    https://git.kernel.org/torvalds/c/3297481d688a5
>
> for reference. So I *think* this config option can be removed on kernel
> side and it appears to me as of v5.17 there should be no need for a
> runtime check regarding PI-futex.

Are there seccomp filters for PI futexes?  I wouldn't be surprised if
people added them after some of the high-profile futex vulnerabilities.
I think we should not support such seccomp filters, but we need to know
what we are up against.

> There shouldn't be any error. There might be the case where the lock
> owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
> handled now but it can't be recognized either. It would require to kill
> the thread owning the lock.
> So either abort the operation if the futex-op returns an error because
> "this shouldn't happen" or I don't know.

ENOMEM needs to be reported to the caller because the application may
want to react to it.

Long term, we should probably have different interfaces for full locking
(with expected failures during locking) and simple mutexes (where
locking can only fail due to memory corruption).

Unlocking must never fail with ENOMEM or similar error codes, it must
always suceed (except if there is memory corruption).

Thanks,
Florian

