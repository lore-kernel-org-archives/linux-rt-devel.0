Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C133314DE
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Jan 2026 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644616; cv=none; b=kRsKFUJzuKSnUf1B4GCPve3wU72rM9oI3ZERDCp3j2DpMcwLduiZyGSeo1z2EoJG+nJfuMVh71XyyQH/OOhMBjXMmB5TIi9ruHRHP5irHX7yGwv62ND6Qy0gsit69Vi2Co7xcp3FpA1pqhZYeI5tFsZXE70q/nAzfpVTdN1qh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644616; c=relaxed/simple;
	bh=5FMCd0ob3YyaiBUznZrd91Sw0D9EqT7fJtCW4ckN3Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqERZorveN6uq9DYVYy8KySzhsBrRpPeEOOWeHu5XtpTMmsg+fk6Ph7zkG1pjBCMUvOa0wRFeSUTOY0sgXEOIlozQDcgOb5iwpKfKPEb3qPqa/vYS5j5DVkgESKDZ/Y8MsG4/ELATGfrsda4ItFqeTtsfo9OyoM/TGnyH/RzQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D5A339;
	Mon,  5 Jan 2026 12:23:26 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA6393F6A8;
	Mon,  5 Jan 2026 12:23:29 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	akpm@linux-oundation.org,
	david@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	jackmanb@google.com,
	vbabka@suse.cz,
	mhocko@suse.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 0/3] fix wrong usage of memory allocation APIs under PREEMPT_RT in arm64
Date: Mon,  5 Jan 2026 20:23:25 +0000
Message-Id: <20260105202328.2418990-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under PREEMPT_RT, calling generic memory allocation/free APIs
(e.x) __get_free_pages(), pgtable_alloc(), free_pages() and etc
with preemption disabled is not allowed, but allow only nolock() APIs series
because it may acquire a spin lock that becomes sleepable on RT,
potentially causing a sleep during page allocation
(See Documentation/core-api/real-time/differences.rst, Memory allocation section).

However, In arm64, __linear_map_split_to_ptes() and
__kpti_install_ng_mappings() called by stopper thread via stop_machine()
use generic memory allocation/free APIs.

This patchset fixes this problem and based on v6.19-rc1

Patch History
==============
from v4 to v5:
  - rebase to v6.19-rc4
  - remove useless __always_inline
  - fix alignments
  - https://lore.kernel.org/all/20260102150736.1378818-1-yeoreum.yun@arm.com/

from v3 to v4:
  - rebase to v6.19-rc3
  - introduce pgtable_alloc_t
  - following several suggestions from @Ryan Roberts
  - https://lore.kernel.org/all/20251218194750.395301-1-yeoreum.yun@arm.com/

from v2 to v3:
  - remove split-mode and split_args.
    pass proper function pointer while spliting.
  - rename function name.
  - https://lore.kernel.org/all/20251217182007.2345700-1-yeoreum.yun@arm.com/

from v1 to v2:
  - drop pagetable_alloc_nolock()
  - following @Ryan Roberts suggestion.
  - https://lore.kernel.org/all/20251212161832.2067134-1-yeoreum.yun@arm.com/

Yeoreum Yun (3):
  arm64: mmu: introduce pgtable_alloc_t
  arm64: mmu: avoid allocating pages while splitting the linear mapping
  arm64: mmu: avoid allocating pages while installing ng-mapping for
    KPTI

 arch/arm64/mm/mmu.c | 241 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 186 insertions(+), 55 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

