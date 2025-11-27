Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBD333758
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254509; cv=none; b=QPvClFzHTCZw8WPCAuBB4dkladQtiKLF1Q4vei95/IMxUwji2wF4OXMJUr5FtIHGxjO5GjnmvbuPbiC7xWgtmgji4hes2gmHN1KE/GWL6pq0AnC4vYQjjkiVFk9DI1L3+9A2PlhS64hmNa4oKMGu0Wb4b1zlY9pi1SN6+FxhMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254509; c=relaxed/simple;
	bh=S+wsllhbJoXpSzjuRs6ALvS49uum7jtLAV3yeCxQZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/R9PCAr6qbZaFkNt7n5TRJViRxhb7SgSwPi6S8ucR+SYUHwa3DygiWDDKwtvUmkRuM+DCkmlq0cBnOsx3iV/8mtIVXZW/QF3fjd/I0JiMp0rWH2C4ijv+NHa5WtzDqclTTP2dTyFRF4xk4qyqxAGdkoebeg/J/z10klXNu29ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYBUa8Ld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOgrARZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYBUa8Ld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOgrARZA"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764254505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UqzZZE1LlVGOe3Wwo5gk2zeWoxauGBlGaiVGbVuZG1Y=;
	b=QYBUa8LdhmETZff6VXXcuqKG2VsBUEDZB7kw9QiZYQjF4WScrx2Nkm9pYufi1jp8nguGIS
	0p1waOlCVcuHPE/nE0hUi8ktPzaEQkRyX+dTwcgHO1QnBLTiKlChE5thNGL8SyMP+dgNv3
	U9zfcJFSk/H/a5wLRRIrhbMt9Aoe5/zGHzQdlh+PNugcZYLV9Pu5HmJAHgHiAFcAp6qRWk
	ZHU9E6nXiCWfoEc1nmENs4/PNDXX8pHnnx4OFvoiqwm+0BDSsDVhvstwTBzymD5rvXZsnx
	PhUEPjpfz4Ptl6Rgm1fgYDen8fLz3dRech7vrPFmiA7qToDQOyjjq93HdLcBzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764254505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UqzZZE1LlVGOe3Wwo5gk2zeWoxauGBlGaiVGbVuZG1Y=;
	b=bOgrARZAza53LuC5C5rw4/XSnicC0ErgnnIDj79sWBOH2/WzULi2UWrlT3J1LaRfQpNjTz
	q7rVf15R1Z+QpbCA==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 RESEND 0/2] locking/local_lock: shadowing and maintainers entry
Date: Thu, 27 Nov 2025 15:41:38 +0100
Message-ID: <20251127144140.215722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a repost of two individual postings earlier:
	https://lore.kernel.org/all/20250927090110.t8Tm9yrk@linutronix.de/=09
	https://lore.kernel.org/all/20251009103900.2Fk8stnM@linutronix.de/

Sebastian Andrzej Siewior (1):
  locking: Add local_locks to MAINTAINERS

Vincent Mailhol (1):
  locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce risk of
    shadowing

 MAINTAINERS                         |  1 +
 include/linux/local_lock_internal.h | 62 ++++++++++++++---------------
 2 files changed, 32 insertions(+), 31 deletions(-)

--=20
2.51.0

