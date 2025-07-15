Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8003192598
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590495; cv=none; b=L0eD60KrMrV7TxQ8sKAA0uTDJUruFvNhe07x38+OyOaxp5muclRQM1+UUYuEUEfbeeEf9Nd5y1YzkoXMc0ZZvLbg7sD1s2gnog+mt/AY+IVQCZSGYVc3qt6ZCQNao3sBZQjS/iwSbCXnaGxsSZJ62HiPHtoL54lI87Ea7nsN7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590495; c=relaxed/simple;
	bh=DUcdR432I1sDxlaqluz63lcyD9M+HeU5YlxbrmfoZik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rydo3khBmezsPPOpL/677ctBLDCkwC8JN/8I50lwaP+/rw2/3PR6a9qdpCFqBm0eKCp0cl4SAV5kHTlEhguMF3/tZklFpNRUaL+D+Km4Rh2eDJtAW3FUGXsJYFXKylONG/y9IHmy2NtJDXEDKo+e6pAO1KQ/nyR0+q6qY/MAfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBNl9syr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hjfh2pzq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBNl9syr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hjfh2pzq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752590491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUR1mJyb2wYnFfA3h+ywAJtas2NdEjPvw6yGse0U/JY=;
	b=GBNl9syrA55AXlW4iC20yBV3cnuC5U0wd+tqFbiuEYznAlqqkvFVXdwW3jPK11uEX9kqN+
	5qKpoVdP5Ac0BI/HIgeEUShcEJUihg/IHw3xisxLszDSOzmJS5x/CoghVs8iAgyE98nD3D
	sEb6PQOpu6xxy+Kgz0ZjMHs1GRGSNDBde8As6xhxcpg25woU1Bo73QptvSRVY+pgeT5kKZ
	vnw+L06S1ENA+xRSBIJ36PFNz6mw8vUFQ414dRIaicVttTcPmAZoVESGf4Tz3hrvvAautd
	FRvqJBY53/X9r7URBGRjSsiMmhijZKn8D7W/OU/u+lq76uRkHZnao80XN7kycQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752590491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUR1mJyb2wYnFfA3h+ywAJtas2NdEjPvw6yGse0U/JY=;
	b=Hjfh2pzq9FpuafJuFr/ae5H5dge23lCg/HXj1wbhYIJ3bl9WpjNie+2wB3MgqD9ojPWhoF
	a1PiuQeOUWftwOAg==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/3] Documentation: Add real-time bits.
Date: Tue, 15 Jul 2025 16:41:24 +0200
Message-ID: <20250715144127.697787-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I tried to put some real-time related documentation.
Patch #1 adds a reference and SPDX tag to seqlock.
Patch #2 extends locktypes with local_lock_nested_bh
Patch #3 adds some real-time bits.

In case there is something missing or unclear, please let me know.

Sebastian

Sebastian Andrzej Siewior (3):
  Documentation: seqlock: Add a reference label and license.
  Documentation: locking: Add local_lock_nested_bh() to locktypes
  Documentation: Add real-time

 Documentation/index.rst                 |   1 +
 Documentation/locking/locktypes.rst     |  21 ++
 Documentation/locking/seqlock.rst       |   4 +
 Documentation/real-time/differences.rst | 244 ++++++++++++++++++++++++
 Documentation/real-time/index.rst       |  18 ++
 Documentation/real-time/theory.rst      | 119 ++++++++++++
 6 files changed, 407 insertions(+)
 create mode 100644 Documentation/real-time/differences.rst
 create mode 100644 Documentation/real-time/index.rst
 create mode 100644 Documentation/real-time/theory.rst

--=20
2.50.0

