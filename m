Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=CDJKOihcU1YVc4uiJQEt21gx5KcS0nub/U92bFHWZxQxnQy3XGLUmb0/cLAMFP2tTbjy
	 6EYEIFtFCFDgZzpTA3sEW+wPcIIjBph+LDv3nWdQCzqW6j8ZwMWSZXgcxkSze7V40S/7K
	 cPf154BBXujAMkuknOePpzuODfE5LHKMdZgfJ6H9Q+/rt92f2gm/C+qHu8PyH2OpHIQoW
	 aNRDpMwbR3EkviMUDHmOm8m1tpsNKriUfIfK11M2vMTkyr8x3T8o5GOOA/xU1N8Ha3/e/
	 xEvDkQxJDQPNdStnA+G7/oox/alYgLc9rV12QoH//ktWbe8vQ+GpELpnN9aCbWmFbBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wt7oLlwiqXLmzKAoSU5vN0ixIevPua7dT/vw9dDykFQ=;
	b=iqxbBbHU8deO4waNzHXHaEYWcPNuhYxqQmBsq8yAZFJSHs8ghIhjO2gfMKQiRQVrKQgm
	 jdbil0eFoSLYSdlaeW2s0EPLwc018DyRoZ2Lu3CkUAOjGA7qzCTooZZ4QIjbcL/dtlE1U
	 IqQe9zSVQQfpybQ/k7Bs9b6JFoJbN0EdMDfjht++Efl833iT1RUiXPGJQfYSapRgDG3Pt
	 /0KLAsChUieLEkQfsHPyeh0lVgk2XNIdI2XXGLTOXedpAviKzAoCEUqK4fAeM+ceOER8T
	 4DvoNUTbTLIrnWVT+6xPGnmvMe94arQXDPOJfyzuUl+RKm/dfa91SPsafGtnuBIzZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=JFpxIH7w;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48D606A686;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D48D606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=JFpxIH7w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=wt7oLlwiqXLmzKAoSU5vN0ixIevPua7dT/vw9dDykFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFpxIH7wpD5EEez0vbmTZ+7FUsukfes6UMnwsdRw9RQZOtIesl+ZuA+ZpPLBdYnra
	 k1LCkK2JmGJo2hgBTXdtLaW1maVkmh3VwB8W8lZ6jTpYbbcDbc+ujjE3ftXmO8M4N7
	 vamlnyfE05tXi2M2lFJ3kX6R8n904xhwHZdPGQI79vxbUWHwpzbZ1R5CL79HFvDGxJ
	 3YqmPBsO6cOmCoWd4LJx6DNazxqZiGOunwvSWTQXXIhXbBqRquCxGik2iOOhXi5URD
	 bcMhiWNPz6oVeEO1oHRlrTMBf7gfk3BKTyKOJ8wHrkJHQeBu7Z4Tp5qA4BIV8H3/Ol
	 2J2aSbgDvDZgg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg1bZVzXPB;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 31/43] sched/deadline: Restore the owner's period at a deboost out of the class
Date: Fri, 27 Nov 2026 08:48:37 -0500
Message-ID: <20261127134846.114774-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234588@kernel.org>
References: <c53e032decdc0ae447feecd391faa770e683dd89.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234588@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Should switched_from_dl() also throttle p->dl and arm p->dl.dl_timer when
> held is true and p->dl.runtime <= 0, the way dl_deboost() does?

Yes. In v12, a task enqueued with no runtime left before its deadline
will be throttled at once, until its next period. Patch 39 then also
asks for a boost there.

Thanks,

Mathieu
