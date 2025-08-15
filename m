Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0147273809
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250746; cv=none; b=SCWSk1Rbcx2d7Zv3335FeK+tAP0X8BtXBY/xkt+bT6TheRGXMuNq1L2sq++FiWC9Zpb2n5sZ1T/hrW1zG1P5ZsSYvFMMftKtLlzqNH5ZQD2L0yE9uEyN9z6PAmJHqmUKDys6m2Kz+dB/oOewR6uKc4Me/ARUBTcJFVQQ1QIZcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250746; c=relaxed/simple;
	bh=Q3puJUn/HAKSDMpirtTXp+Yw7D2tl5Y5DEvERyJ2kMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hjo9h8B1GXWsuP4e1XsiOOAcdoFivn7TRBERNaSNDh7qjUCXwMc4pF8QoiizCPQ4qE84wBfyuGdn4bTZWscRRkzG3DntAHBEuRKT26Y3a2WnFeS4N2vnNPDemzfnzu7JZlBnG3oUfOs6VwV9/WPmiRs9Qo80wNAt5hHheHQLnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JAfYPJvb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhOLfzRI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JAfYPJvb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhOLfzRI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755250741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ikeRdbQOYr+OmVwxL5RnSd1+MKzxVd+VFeP3B4z/VWE=;
	b=JAfYPJvb25GHkQorIwRmsuPW3yBmum+U+Q3yVNUGpbpUQU5V/J645lzzjN7V7EZ4vZipxO
	Um7XEolZ4WiXWeTNrKPO3L20qlHN1ylcZR1jKonrJLjOxMzOx4xFji/ACTfXO4TawGV3UU
	pzs+Sld5PQup19q5nDApZfH4WWMQA9zFI2yJjyj1uT8B4rieuV4k/P9ctubw6Wkh5PNJcK
	E+v5ukq0fyxbY+m+xWbYD/HSXuObi7TxeJnii8iJX1ldjYSANqeBlQYFPRihqyuIEbC9xU
	arHPCOqZ4pBFl0ZXQaT9nRR/Q3gxVB4025OQXLaX50GS3RGepJ6SmVItmXOZ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755250741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ikeRdbQOYr+OmVwxL5RnSd1+MKzxVd+VFeP3B4z/VWE=;
	b=BhOLfzRIxX1bszWBMdE3zm0TPJp4O8VRgcWPRtNYJj3UEUmISCz+nS9IrTbiLKkDcL8dza
	jhdxkRjoo900xuBQ==
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
Subject: [PATCH v2 0/3] Documentation: Add real-time bits.
Date: Fri, 15 Aug 2025 11:38:54 +0200
Message-ID: <20250815093858.930751-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I tried to put some real-time related documentation.=20=20=20
Patch #1 SPDX tag to seqlock.
Patch #2 extends locktypes with local_lock_nested_bh
Patch #3 adds some real-time bits.

In case there is something missing or unclear, please let me know.

v1=E2=80=A6v2:
  - #1 does not add a reference tag anymore.
  - #2 wording/ typo in #2
  - #3 is moved to core-api
  - #3 does not uses rst references but uses the plain file name
  - #3 is extended with some notes for architecture porting.

Sebastian Andrzej Siewior (3):
  Documentation: seqlock: Add a SPDX license identifier
  Documentation: locking: Add local_lock_nested_bh() to locktypes
  Documentation: Add real-time to core-api

 Documentation/core-api/index.rst              |   1 +
 .../real-time/architecture-porting.rst        | 109 ++++++++
 .../core-api/real-time/differences.rst        | 242 ++++++++++++++++++
 Documentation/core-api/real-time/index.rst    |  16 ++
 Documentation/core-api/real-time/theory.rst   | 116 +++++++++
 Documentation/locking/locktypes.rst           |  21 ++
 Documentation/locking/seqlock.rst             |   2 +
 7 files changed, 507 insertions(+)
 create mode 100644 Documentation/core-api/real-time/architecture-porting.r=
st
 create mode 100644 Documentation/core-api/real-time/differences.rst
 create mode 100644 Documentation/core-api/real-time/index.rst
 create mode 100644 Documentation/core-api/real-time/theory.rst

--=20
2.50.1

