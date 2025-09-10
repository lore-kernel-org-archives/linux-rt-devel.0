Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF52D73BC
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483854; cv=none; b=jgQWuyZh+TaGbbHFA8dXGR7KGyMKZ3jjEF2RRItc3egjOkAWVg4z1yvK76i2Hj5f6fLt036v2CEkdxO7lMqBR2xhp9Q2BpZOc+KPszNyUwmN++9UXooXZqnXTNhKdMq5GssVcBEt3ee8yaKLV5CFBMaDL37+GbrT8KETxu/hybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483854; c=relaxed/simple;
	bh=uMAK0Z4HD8moAbze5BY0sTguYXj2iUFQpeXVYnClu5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tcLsD9GscRXUgjAYesvEQp5g56fPeaXtchWU4PIR+v9cB0oUlMqx8GYEzx7jHTSbNi+uQVUbsNIvfuIGLMYdavdjEqT1od5exLnh1jthxazdruCE5b6hdmsnIm1TYoOUAmqHG76Ln1N/x53Hy0fdme5kSYFg1Ujwcm7W3SjjHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxyJg+sX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxyJg+sX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757483851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENQIafnN2Y8HAkNyZMMi2qzOXDLdq0pydzF/WqXQEq8=;
	b=AxyJg+sXFYtzFAok/JcuCWsmSkKi3EQELNIeugEuGvy0e3wrPm9c3viMU4A7h3TC2WMCvM
	TRnjoDYzMNnO6RDhb4H+9/ZRV1TbbNE9JA4TOWlg1D2p3mfItjBxPeVB8jXZ8HsMvZCLzl
	UxvMgtLUey/CazkIEflIJ3SOVFMfRmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-WKxzkxyePAOJGoGjoi6PzQ-1; Wed,
 10 Sep 2025 01:57:28 -0400
X-MC-Unique: WKxzkxyePAOJGoGjoi6PzQ-1
X-Mimecast-MFC-AGG-ID: WKxzkxyePAOJGoGjoi6PzQ_1757483846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A06FE180045C;
	Wed, 10 Sep 2025 05:57:26 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EB521800447;
	Wed, 10 Sep 2025 05:57:23 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  libc-alpha@sourceware.org,  John Ogness <john.ogness@linutronix.de>,
  linux-rt-devel@lists.linux.dev,  Thomas Gleixner <tglx@linutronix.de>,
  Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
In-Reply-To: <437ea968-d726-40c9-a833-08d94c5fe105@linaro.org> (Adhemerval
	Zanella Netto's message of "Tue, 9 Sep 2025 16:14:11 -0300")
References: <20250908163329.Qq79ujq_@linutronix.de>
	<4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
	<20250909073226.0qoHYZMo@linutronix.de>
	<lhubjnjbyt9.fsf@oldenburg.str.redhat.com>
	<20250909153758.JD5t64rY@linutronix.de>
	<lhubjnja8ng.fsf@oldenburg.str.redhat.com>
	<437ea968-d726-40c9-a833-08d94c5fe105@linaro.org>
Date: Wed, 10 Sep 2025 07:57:21 +0200
Message-ID: <lhu1poealz2.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -P0FhyGSHDOGXc6-4mBcTZtXt1vBAzGiNZbN83ENldI_1757483846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

* Adhemerval Zanella Netto:

>> Does POSIX define what happens if a non-robust mutex is accessed again
>> if a thread terminates without unlocking it first?  If yes, then this is
>> indeed a problem.
>
> Afaik this is UB for non-robust mutexes, although the resolution for Austin
> Issue 755  [1] is not clear IMHO.
>
> [1] https://www.austingroupbugs.net/view.php?id=755#c1875

Ah, so it's UB in practically all implementations (for at least some
mutex types), but not UB in POSIX.

Thanks,
Florian

