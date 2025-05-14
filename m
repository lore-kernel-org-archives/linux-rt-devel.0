Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C1136351
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 May 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232049; cv=none; b=PPHltUL238XXKqZ6jrujKBJwP1Tc4UPgVjVc41JhiU/K4fODKLIQwj4PRRt9SULwQC3fH6F3ZRg78qSSvgG8nCCUqBIRULGrfHU0wiv4s9CdRtKeovwc+yz43bV4AXjiMEugBFIHQyXOh129bNWoklbAwUY8gQ8IKdb60X3mTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232049; c=relaxed/simple;
	bh=I0sminW4IkwuCW/0W6uZGifwxZ+LnPI2ndnV6UJbjg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UI7GSSiqO0S/FxL0PcVUT25tIrS2Ipa8GcusqAdQntkGRQzjYjmOvm3Xudy79sI3oX96BFeHJB5lbJF4MKO2yGFD9cxvtAD807TDqcJp1AqRtfVQppMmEnDu8WkLuuMxOYX3/m4Zp09jEuEnDkRj0XLFmSiakuq3fCLIE/e5VY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWV9owBz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWV9owBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0sminW4IkwuCW/0W6uZGifwxZ+LnPI2ndnV6UJbjg0=;
	b=BWV9owBzM9eIiodo60juKtfawzl7Ox4Q1diE+TrlJQlQqQ+pjVmzbgZ5A4aTnoANKdrl7e
	BhfanEn1Uq4eiwLZPVKQP5/0Fmm3q+eeQBJteVPYE7/S2ba9x5/aRBqgWXhs8pMQpagWKn
	GA+X1yxWhe9tJ522uruR5xv2wzQn7xI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-J6KUNro3NLCShhtV9nPBHA-1; Wed,
 14 May 2025 10:14:03 -0400
X-MC-Unique: J6KUNro3NLCShhtV9nPBHA-1
X-Mimecast-MFC-AGG-ID: J6KUNro3NLCShhtV9nPBHA_1747232041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C71A180087A;
	Wed, 14 May 2025 14:14:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D2DE30001A1;
	Wed, 14 May 2025 14:13:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v4 07/15] openvswitch: Merge three
 per-CPU structures into one
In-Reply-To: <20250512092736.229935-8-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Mon, 12 May 2025 11:27:28 +0200")
References: <20250512092736.229935-1-bigeasy@linutronix.de>
	<20250512092736.229935-8-bigeasy@linutronix.de>
Date: Wed, 14 May 2025 10:13:56 -0400
Message-ID: <f7ta57fe0uz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> exec_actions_level is a per-CPU integer allocated at compile time.
> action_fifos and flow_keys are per-CPU pointer and have their data
> allocated at module init time.
> There is no gain in splitting it, once the module is allocated, the
> structures are allocated.
>
> Merge the three per-CPU variables into ovs_pcpu_storage, adapt callers.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

